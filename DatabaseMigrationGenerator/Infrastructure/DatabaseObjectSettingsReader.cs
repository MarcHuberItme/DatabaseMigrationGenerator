// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class DatabaseObjectSettingsReader : IDatabaseObjectSettingsReader
    {
        public async Task<IEnumerable<IDatabaseObjectSettings>> ReadAsync(string migrationsPath)
        {
            return new List<IDatabaseObjectSettings> {
                new TableObjectSettings()
            };
        }
    }
}