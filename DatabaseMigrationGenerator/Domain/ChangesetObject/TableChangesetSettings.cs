// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject
{
    public class TableChangesetSettings : ChangesetSettingsBase
    {
        public override ChangesetType Type => ChangesetType.Table;
        public bool IsReleaseFile { get; init; }

        public override List<string> Validate()
        {
            var errors = base.Validate();

            if (IsReleaseFile) {
                ChangesetValidators.ValidateReleaseFileName(errors, SourceFilePath);
            }

            return errors;
        }
    }
}
