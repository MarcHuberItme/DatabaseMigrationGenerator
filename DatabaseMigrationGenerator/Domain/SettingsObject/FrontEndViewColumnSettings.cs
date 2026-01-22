// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class FrontEndViewColumnSettings
    {
        public string Name { get; init; } = string.Empty;

        public string? Description { get; init; }

        public string? DataType { get; init; }

        public bool IsNotNull { get; init; }

        public bool IsUnique { get; init; }

        public string? DefaultValue { get; init; }

        public int Prec { get; init; }

        public int Scale { get; init; }

        public string? MinValue { get; init; }

        public string? MaxValue { get; init; }

        public GenericControlsSettings? GenericControls { get; init; }

        private const int MaxNameLength = 30;
        private const int MaxValueLength = 30;

        public List<string> Validate()
        {
            var errors = new List<string>();

            SettingsValidators.ValidateName(errors, Name, MaxNameLength, "Column");
            SettingsValidators.ValidateDescription(errors, Description, prefix: $"Column '{Name}':");
            SettingsValidators.ValidateStringField(errors, MinValue, $"Column '{Name}': MinValue", MaxValueLength);
            SettingsValidators.ValidateStringField(errors, MaxValue, $"Column '{Name}': MaxValue", MaxValueLength);
            SettingsValidators.ValidateStringField(errors, DefaultValue, $"Column '{Name}': DefaultValue", MaxValueLength);
            ValidateGenericControls(errors);

            return errors;
        }

        private void ValidateGenericControls(List<string> errors)
        {
            if (GenericControls is null) {
                return;
            }

            errors.AddRange(GenericControls.Validate());
        }
    }
}
