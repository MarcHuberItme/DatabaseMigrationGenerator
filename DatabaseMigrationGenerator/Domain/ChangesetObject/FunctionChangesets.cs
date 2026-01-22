// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject
{
    public class FunctionChangesets : ChangesetsBase
    {
        public override ChangesetType Type => ChangesetType.Function;

        protected override void ValidateSql(List<string> errors, string sql, int index)
        {
            ChangesetValidators.ValidateFunctionSql(errors, sql, index);
        }
    }
}
