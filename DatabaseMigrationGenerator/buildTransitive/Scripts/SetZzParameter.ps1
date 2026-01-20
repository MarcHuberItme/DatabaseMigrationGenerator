# Define variables
$serverName   = ".\SQLDEVELOPER"
$databaseName = "FsFinDev"

# Establish connection (Windows Authentication)
$connectionString = "Server=$serverName;Database=$databaseName;Integrated Security=True;"
$connection = New-Object System.Data.SqlClient.SqlConnection $connectionString
$connection.Open()

# Set the value you want to write into ParValue
$newValue = ".\SQLDEVELOPER"

# Update the two keys in the key/value table
$sqlQuery = @"
UPDATE dbo.zzParameter
SET ParValue = @newValue
WHERE ParKey IN ('ArchiveServer', 'Server');
"@

$command = $connection.CreateCommand()
$command.CommandText = $sqlQuery

# Parameter to avoid quoting issues / injection
$null = $command.Parameters.Add("@newValue", [System.Data.SqlDbType]::NVarChar, 255)
$command.Parameters["@newValue"].Value = $newValue

$rows = $command.ExecuteNonQuery()

$connection.Close()

Write-Host "Updated $rows row(s) successfully (set ArchiveServer and Server in zzParameter to '$newValue' - server name: $serverName)!"

