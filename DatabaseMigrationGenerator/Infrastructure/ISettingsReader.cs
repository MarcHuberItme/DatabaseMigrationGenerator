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
        Task<(IEnumerable<ISettings> settings, int totalScanned)> ReadAsync(string migrationsPath, IProgress<(int current, int total)>? progress = null);
    }
}