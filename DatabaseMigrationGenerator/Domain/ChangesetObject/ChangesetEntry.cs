// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject
{
    public class ChangesetEntry
    {
        public string Header { get; init; } = string.Empty;
        public string Comment { get; init; } = string.Empty;
        public string Sql { get; init; } = string.Empty;
    }
}
