// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class ViewSettings() : SettingsBase
    {
        public string Name { get; init; } = string.Empty;

        public string? Description { get; init; } = string.Empty;

        private const int MaxNameLength = 128;

        public override List<string> Validate()
        {
            var errors = new List<string>();

            SettingsValidators.ValidateName(errors, Name, MaxNameLength);
            SettingsValidators.ValidateDescription(errors, Description);

            return errors;
        }
    }
}
