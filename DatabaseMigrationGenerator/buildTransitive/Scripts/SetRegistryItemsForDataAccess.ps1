# ==============================
# Configuration
# ==============================

$EnvironmentName = "FinDevLocal"   # e.g. FinDevLocal, FinTest, FinProd

$BaseRegistryKey = "HKLM:\SOFTWARE\WOW6432Node\FinStar"
$RegistryKey     = "$BaseRegistryKey\$EnvironmentName\DataAccess"

$BaseCachePath   = "D:\FinStar\AppServer\cache"
$EnvironmentPath = Join-Path $BaseCachePath $EnvironmentName

$MasterDbConnectionString = "Provider=MSOLEDBSQL;DataTypeCompatibility=80;Initial Catalog=FsFinDev;Trusted_Connection=yes;Data Source=.\SQLDEVELOPER"

$CacheFolders = @(
    "Empty",
    "List",
    "Report",
    "Template"
)

# ==============================
# Ensure Cache Folders exist
# ==============================

foreach ($folder in $CacheFolders) {
    $fullPath = Join-Path $EnvironmentPath $folder

    if (-not (Test-Path $fullPath)) {
        New-Item -Path $fullPath -ItemType Directory -Force | Out-Null
    }
}

# ==============================
# Ensure Registry Key exists
# ==============================

if (-not (Test-Path $RegistryKey)) {
    New-Item -Path $RegistryKey -Force | Out-Null
}

# ==============================
# Write Registry Values
# ==============================

Set-ItemProperty -Path $RegistryKey -Name "EmptyCachePath"    -Value (Join-Path $EnvironmentPath "Empty")
Set-ItemProperty -Path $RegistryKey -Name "ListCachePath"     -Value (Join-Path $EnvironmentPath "List")
Set-ItemProperty -Path $RegistryKey -Name "ReportCachePath"   -Value (Join-Path $EnvironmentPath "Report")
Set-ItemProperty -Path $RegistryKey -Name "TemplateCachePath" -Value (Join-Path $EnvironmentPath "Template")
Set-ItemProperty -Path $RegistryKey -Name "ShapeProvider"     -Value "MSDataShape"
Set-ItemProperty -Path $RegistryKey -Name "MasterDb"          -Value $MasterDbConnectionString

# ==============================
# Output
# ==============================

Write-Host ""
Write-Host "Cache folders ensured under:"
Write-Host $EnvironmentPath
Write-Host ""
Write-Host "Registry values successfully written to:"
Write-Host $RegistryKey
Write-Host ""
