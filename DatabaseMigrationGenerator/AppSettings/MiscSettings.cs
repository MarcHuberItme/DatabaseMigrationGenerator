// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.AppSettings
{
    public class MiscSettings
    {
        public string MigrationsDirectoryName { get; set; } = string.Empty;

        public string BaseDirectoryPath { get; set; } = string.Empty;

        public string DoNotCreateTriggersForTables { get; set; } = string.Empty;

        public string DoNotCreateGetDetailAndGetListForStoredProcedures { get; set; } = string.Empty;

        public string MigrationsDirectoryPath(string basePath)
        {
            var rootPath = basePath;
            if (!string.IsNullOrEmpty(BaseDirectoryPath)) {
                rootPath = BaseDirectoryPath;
            }
            var migrationsDirectoryPath = Path.Combine(rootPath, MigrationsDirectoryName);
            return migrationsDirectoryPath;
        }
    }
}