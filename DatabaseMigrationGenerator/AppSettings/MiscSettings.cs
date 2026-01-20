// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.AppSettings
{
    public class MiscSettings
    {
        public string DoNotCreateTriggersForTables { get; init; }
        public string DoNotCreateGetDetailAndGetListForStoredProcedures { get; init; }
    }
}