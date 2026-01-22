// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject
{
    public abstract class ChangesetSettingsBase : IChangesetSettings
    {
        public string SourceFilePath { get; set; } = string.Empty;
        public abstract ChangesetType Type { get; }
        public string ChangesetRoot { get; init; } = string.Empty;
        public List<ChangesetEntry> Changesets { get; init; } = [];

        public virtual List<string> Validate()
        {
            var errors = new List<string>();

            ChangesetValidators.ValidateChangesetRoot(errors, ChangesetRoot);

            for (int i = 0; i < Changesets.Count; i++) {
                var changeset = Changesets[i];
                ChangesetValidators.ValidateChangesetHeader(errors, changeset.Header, i);
                ChangesetValidators.ValidateComment(errors, changeset.Comment, i);
                ValidateSql(errors, changeset.Sql, i);
            }

            return errors;
        }

        protected virtual void ValidateSql(List<string> errors, string sql, int index)
        {
            ChangesetValidators.ValidateSql(errors, sql, index);
        }
    }
}
