// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject
{
    public class StoredProcedureChangesetSettings : ChangesetSettingsBase
    {
        public override ChangesetType Type => ChangesetType.StoredProcedure;

        protected override void ValidateSql(List<string> errors, string sql, int index)
        {
            ChangesetValidators.ValidateStoredProcedureSql(errors, sql, index);
        }
    }
}
