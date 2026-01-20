// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.HeaderTable;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public interface IHeaderTableSettingsReader
    {
        Task<IEnumerable<HeaderTableSettings>> ReadAsync(string migrationsPath);
    }
}