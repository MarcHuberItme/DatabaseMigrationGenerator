// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.DatabaseObject
{
    public class TableObjectSettings : IDatabaseObjectSettings
    {
        public TableObject Table { get; init; } = new();
    }
}