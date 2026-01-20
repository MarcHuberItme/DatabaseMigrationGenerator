// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Application
{
    public class CreateChangeSetsCommand(
        string migrationsPath)
    {
        public string MigrationsPath { get; } = migrationsPath;
    }
}