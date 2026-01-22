// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public abstract class ColumnSettingsBase
    {
        public string Name { get; init; } = string.Empty;

        public string? Description { get; init; } = string.Empty;

        public string? MinValue { get; init; }

        public string? MaxValue { get; init; }

        public string? DefaultValue { get; init; }

        public abstract GenericControlsSettings? GenericControls { get; init; }

        private const int MaxNameLength = 30;
        private const int MaxValueLength = 30;

        public List<string> Validate()
        {
            var errors = new List<string>();

            ValidateName(errors);
            ValidateDescription(errors);
            ValidateValueFields(errors);
            ValidateGenericControls(errors);

            return errors;
        }

        private void ValidateName(List<string> errors)
        {
            SettingsValidators.ValidateName(errors, Name, MaxNameLength, "Column");
        }

        private void ValidateDescription(List<string> errors)
        {
            SettingsValidators.ValidateDescription(errors, Description, prefix: $"Column '{Name}':");
        }

        private void ValidateValueFields(List<string> errors)
        {
            SettingsValidators.ValidateStringField(errors, MinValue, $"Column '{Name}': MinValue", MaxValueLength);
            SettingsValidators.ValidateStringField(errors, MaxValue, $"Column '{Name}': MaxValue", MaxValueLength);
            SettingsValidators.ValidateStringField(errors, DefaultValue, $"Column '{Name}': DefaultValue", MaxValueLength);
        }

        private void ValidateGenericControls(List<string> errors)
        {
            if (GenericControls is null) return;
            errors.AddRange(GenericControls.Validate());
        }
    }
}
