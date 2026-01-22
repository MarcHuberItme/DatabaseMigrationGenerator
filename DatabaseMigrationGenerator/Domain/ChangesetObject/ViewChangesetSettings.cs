// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject
{
    public class ViewChangesetSettings : ChangesetSettingsBase
    {
        public override ChangesetType Type => ChangesetType.View;

        protected override void ValidateSql(List<string> errors, string sql, int index)
        {
            ChangesetValidators.ValidateViewSql(errors, sql, index);
        }
    }
}
