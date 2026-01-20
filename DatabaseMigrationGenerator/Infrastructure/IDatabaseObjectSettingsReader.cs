// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.DatabaseObject;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public interface IDatabaseObjectSettingsReader
    {
        Task<IEnumerable<IDatabaseObjectSettings>> ReadAsync(string migrationsPath);
    }
}