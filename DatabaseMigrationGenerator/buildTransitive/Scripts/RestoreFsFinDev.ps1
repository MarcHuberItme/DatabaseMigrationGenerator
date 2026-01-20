<#
.SYNOPSIS
  Restores a selected .bak file from a network share to SQL Server instance .\SQLDEVELOPER.
  Shows a dialog with a dropdown and OK/Cancel.
  Copies the selected .bak to a local folder first (so SQL Server service does not need UNC access),
  then uses RESTORE FILELISTONLY to build MOVE clauses dynamically and restores via sqlcmd.

.NOTES
  - Source: \\fsrep01\BuildOutput\BackupFsFinDev
  - Local staging: C:\Temp
  - Restores all DB files (data + log) into: D:\SqlDeveloper\MSSQL15.SQLDEVELOPER\MSSQL\DATA
#>

# =========================
# Variables (define all here)
# =========================
$BackupFolderUNC   = "\\fsrep01\BuildOutput\BackupFsFinDev"
$BackupExtension   = "*.bak"

$LocalStagingDir   = "C:\Temp"          # local copy target
$LocalBakPrefix    = "Restore_"         # optional prefix for local file name to avoid collisions

$SqlInstance       = ".\SQLDEVELOPER"
$TargetDatabase    = "FsFinDev"

$DataDirectory     = "D:\SqlDeveloper\MSSQL15.SQLDEVELOPER\MSSQL\DATA"

$SqlCmdExe         = "sqlcmd"           # assumes sqlcmd is in PATH
$SqlAuthArgs       = @("-E")            # Windows authentication; replace with -U/-P if needed

$StatsPercent      = 5
$TempSqlFile       = Join-Path $env:TEMP ("restore_{0}_{1}.sql" -f $TargetDatabase, (Get-Date -Format "yyyyMMdd_HHmmss"))

# =========================
# 1) SQL-Cmdlets (Invoke-Sqlcmd etc.)
# =========================
if (-not (Get-Command Invoke-Sqlcmd -ErrorAction SilentlyContinue)) {
    Write-Host "Invoke-Sqlcmd not found – trying to install the SqlServer module..." -ForegroundColor Yellow
    try {
        Install-Module SqlServer -Scope AllUsers -Force -AllowClobber -ErrorAction Stop
        Import-Module SqlServer -ErrorAction Stop
        Write-Host "SqlServer module successfully installed and imported." -ForegroundColor Green
    }
    catch {
        Write-Error ("Could not install/import SqlServer module: {0}" -f $_.Exception.Message)
        throw
    }
}
else {
    Write-Host "Invoke-Sqlcmd is already available – skipping installation/import of SqlServer." -ForegroundColor Green
}

# =========================
# Helper: Get .bak files from UNC
# =========================
if (-not (Test-Path $BackupFolderUNC)) {
    throw "Backup folder not reachable: $BackupFolderUNC"
}

$bakFiles = Get-ChildItem -Path $BackupFolderUNC -Filter $BackupExtension -File -ErrorAction Stop | Sort-Object Name
if (-not $bakFiles -or $bakFiles.Count -eq 0) {
    throw "No .bak files found in: $BackupFolderUNC"
}

# Map display name (without .bak) -> full path
$bakMap = @{}
foreach ($f in $bakFiles) {
    $base = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
    $bakMap[$base] = $f.FullName
}

# =========================
# 2) UI dialog (Windows Forms)
# =========================
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Restore Database Backup"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(520, 180)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.TopMost = $true

$label = New-Object System.Windows.Forms.Label
$label.Text = "Select a backup to restore:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(12, 15)
$form.Controls.Add($label)

$combo = New-Object System.Windows.Forms.ComboBox
$combo.DropDownStyle = "DropDownList"
$combo.Location = New-Object System.Drawing.Point(15, 40)
$combo.Size = New-Object System.Drawing.Size(475, 25)
[void]$combo.Items.AddRange($bakMap.Keys)
$combo.SelectedIndex = 0
$form.Controls.Add($combo)

$btnOK = New-Object System.Windows.Forms.Button
$btnOK.Text = "OK"
$btnOK.Size = New-Object System.Drawing.Size(100, 30)
$btnOK.Location = New-Object System.Drawing.Point(280, 85)
$btnOK.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $btnOK
$form.Controls.Add($btnOK)

$btnCancel = New-Object System.Windows.Forms.Button
$btnCancel.Text = "Cancel"
$btnCancel.Size = New-Object System.Drawing.Size(100, 30)
$btnCancel.Location = New-Object System.Drawing.Point(390, 85)
$btnCancel.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $btnCancel
$form.Controls.Add($btnCancel)

$result = $form.ShowDialog()
if ($result -ne [System.Windows.Forms.DialogResult]::OK) {
    Write-Host "Cancelled by user." -ForegroundColor Yellow
    return
}

$selectedBaseName = [string]$combo.SelectedItem
$selectedBakPath  = $bakMap[$selectedBaseName]

Write-Host ("Selected backup (UNC): {0}" -f $selectedBakPath)

# =========================
# 3) Check temp directory exists and free disk space in C:\Temp before copy
# =========================
if (-not (Test-Path $LocalStagingDir)) {
    Write-Host ("Local staging folder does not exist. Creating: {0}" -f $LocalStagingDir) -ForegroundColor Yellow
    New-Item -Path $LocalStagingDir -ItemType Directory -Force | Out-Null
}

# Get size of source .bak file (bytes)
$bakFileSizeBytes = (Get-Item $selectedBakPath).Length

# Get free space on drive where C:\Temp resides
$driveLetter = (Get-Item $LocalStagingDir).PSDrive.Name
$driveInfo   = Get-PSDrive -Name $driveLetter
$freeBytes   = $driveInfo.Free

# Optional safety buffer (e.g. +10%)
$safetyFactor = 1.10
$requiredBytes = [math]::Ceiling($bakFileSizeBytes * $safetyFactor)

if ($freeBytes -lt $requiredBytes) {
    throw ("Not enough free disk space on drive {0}. Required: {1:N2} GB, Available: {2:N2} GB" -f `
        $driveLetter,
    ($requiredBytes / 1GB),
    ($freeBytes / 1GB))
}

Write-Host ("Disk space check OK. Required: {0:N2} GB, Available: {1:N2} GB" -f `
    ($requiredBytes / 1GB),
($freeBytes / 1GB)) -ForegroundColor Green

# =========================
# 4) Copy .bak to local staging folder (C:\Temp) and work from there
# =========================
# Use a timestamped local filename to avoid file-in-use/collisions
$timestamp     = Get-Date -Format "yyyyMMdd_HHmmss"
$localBakName  = "{0}{1}_{2}.bak" -f $LocalBakPrefix, $selectedBaseName, $timestamp
$localBakPath  = Join-Path $LocalStagingDir $localBakName

Write-Host ("Copying backup to local path: {0}" -f $localBakPath)
Copy-Item -Path $selectedBakPath -Destination $localBakPath -Force -ErrorAction Stop

# Basic sanity check
if (-not (Test-Path $localBakPath)) {
    throw "Copy failed: local backup not found at $localBakPath"
}

# =========================
# 5) Build MOVE clauses dynamically via RESTORE FILELISTONLY (LOCAL PATH)
# =========================
if (-not (Test-Path $DataDirectory)) {
    throw "Data directory does not exist: $DataDirectory"
}

# Escape single quotes for T-SQL string literal
$bakPathSql = $localBakPath.Replace("'", "''")

Write-Host "Reading file list from local backup (RESTORE FILELISTONLY)..."
$fileList = Invoke-Sqlcmd -ServerInstance $SqlInstance -Query "RESTORE FILELISTONLY FROM DISK = N'$bakPathSql';" -ErrorAction Stop

if (-not $fileList -or $fileList.Count -eq 0) {
    throw "RESTORE FILELISTONLY returned no rows. The backup might be invalid."
}

$moveClauses = New-Object System.Collections.Generic.List[string]
foreach ($row in $fileList) {
    # Use original filename (from PhysicalName) but force directory to $DataDirectory
    $originalFileName = [System.IO.Path]::GetFileName([string]$row.PhysicalName)
    if ([string]::IsNullOrWhiteSpace($originalFileName)) {
        # Fallback: LogicalName + extension based on type
        $ext = if ($row.Type -eq "L") { ".ldf" } else { ".ndf" }
        $originalFileName = ("{0}{1}" -f $row.LogicalName, $ext)
    }

    $destPath     = Join-Path $DataDirectory $originalFileName
    $destPathSql  = $destPath.Replace("'", "''")
    $logicalName  = ([string]$row.LogicalName)
    $logicalNameSql = $logicalName.Replace("'", "''")

    $moveClauses.Add("MOVE N'$logicalNameSql' TO N'$destPathSql'")
}

$moveSql = $moveClauses -join (",`r`n    ")

# =========================
# 6) Create restore script (sqlcmd) and execute (LOCAL PATH)
# =========================
Write-Host "Preparing restore script..."

$restoreSql = @"
-- Auto-generated restore script
SET NOCOUNT ON;

DECLARE @db sysname = N'$($TargetDatabase.Replace("'","''"))';

IF DB_ID(@db) IS NOT NULL
BEGIN
    PRINT 'Setting database to SINGLE_USER with ROLLBACK IMMEDIATE...';
    EXEC('ALTER DATABASE [' + @db + '] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;');
END
ELSE
BEGIN
    PRINT 'Database does not exist yet. It will be created by RESTORE.';
END

PRINT 'Restoring database from local backup file...';
RESTORE DATABASE [$TargetDatabase]
FROM DISK = N'$bakPathSql'
WITH
    REPLACE,
    $moveSql,
    RECOVERY,
    STATS = $StatsPercent;

PRINT 'Setting database back to MULTI_USER...';
ALTER DATABASE [$TargetDatabase] SET MULTI_USER;

PRINT 'Done.';
"@

Set-Content -Path $TempSqlFile -Value $restoreSql -Encoding UTF8

Write-Host ("Executing restore via sqlcmd on instance {0}..." -f $SqlInstance)

# -b makes sqlcmd return a non-zero exit code on error
$arguments = @("-S", $SqlInstance) + $SqlAuthArgs + @("-b", "-i", $TempSqlFile)

$proc = Start-Process -FilePath $SqlCmdExe -ArgumentList $arguments -NoNewWindow -Wait -PassThru

if ($proc.ExitCode -ne 0) {
    Write-Error ("Restore failed. sqlcmd exit code: {0}. Script kept at: {1}" -f $proc.ExitCode, $TempSqlFile)
    Write-Host ("Local backup copy kept at: {0}" -f $localBakPath) -ForegroundColor Yellow
    throw "Restore failed."
}

# =========================
# 7) Cleanup: delete local .bak file
# =========================
if (Test-Path $localBakPath) {
    try {
        Remove-Item -Path $localBakPath -Force -ErrorAction Stop
        Write-Host ("Local backup file deleted: {0}" -f $localBakPath)
    }
    catch {
        Write-Warning ("Failed to delete local backup file {0}: {1}" -f $localBakPath, $_.Exception.Message)
    }
}


Write-Host ("Restore completed successfully. Script used: {0}" -f $TempSqlFile) -ForegroundColor Green
Write-Host ("Local backup copy: {0}" -f $localBakPath)
