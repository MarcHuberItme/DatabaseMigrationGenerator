// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.SettingsObject;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public interface ISettingsReader
    {
        Task<IEnumerable<ISettings>> ReadAsync(string migrationsPath, Action<int, int>? onProgress = null);
    }
}