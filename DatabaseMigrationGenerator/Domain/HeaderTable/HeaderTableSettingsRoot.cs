// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.HeaderTable
{
    public class HeaderTableSettingsRoot
    {
        public IEnumerable<HeaderTableSettings> HeaderTables { get; init; } = new List<HeaderTableSettings>();
    }
}