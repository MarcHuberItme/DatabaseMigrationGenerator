// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public interface IChangesetReader
    {
        Task<IEnumerable<IChangesets>> ReadAsync(
            string migrationsPath,
            Action<int, int>? progressCallback = null);
    }
}
