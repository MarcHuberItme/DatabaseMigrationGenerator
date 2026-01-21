// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.Text.RegularExpressions;

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
        private const int MaxDescriptionLength = 2000;
        private const int MaxValueLength = 30;
        private static readonly Regex AllowedNamePattern = new(@"^[a-zA-Z0-9_]+$", RegexOptions.Compiled);

        public List<string> Validate()
        {
            var errors = new List<string>();

            ValidateName(errors);
            ValidateDescription(errors);
            ValidateMinValue(errors);
            ValidateMaxValue(errors);
            ValidateDefaultValue(errors);
            ValidateGenericControls(errors);

            return errors;
        }

        private void ValidateName(List<string> errors)
        {
            if (string.IsNullOrEmpty(Name)) {
                errors.Add("Column Name is required.");
                return;
            }

            if (Name.Length > MaxNameLength) {
                errors.Add($"Column '{Name}': {nameof(Name)} must not exceed {MaxNameLength} characters.");
            }

            if (!AllowedNamePattern.IsMatch(Name)) {
                errors.Add($"Column '{Name}': {nameof(Name)} must only contain letters (a-z, A-Z), digits (0-9), and underscores (_).");
            }
        }

        private void ValidateDescription(List<string> errors)
        {
            if (string.IsNullOrEmpty(Description)) {
                return;
            }

            if (Description.Length > MaxDescriptionLength) {
                errors.Add($"Column '{Name}': {nameof(Description)} must not exceed {MaxDescriptionLength} characters.");
            }
        }

        private void ValidateMinValue(List<string> errors)
        {
            if (string.IsNullOrEmpty(MinValue)) {
                return;
            }

            if (MinValue.Length > MaxValueLength) {
                errors.Add($"Column '{Name}': {nameof(MinValue)} must not exceed {MaxValueLength} characters.");
            }
        }

        private void ValidateMaxValue(List<string> errors)
        {
            if (string.IsNullOrEmpty(MaxValue)) {
                return;
            }

            if (MaxValue.Length > MaxValueLength) {
                errors.Add($"Column '{Name}': {nameof(MaxValue)} must not exceed {MaxValueLength} characters.");
            }
        }

        private void ValidateDefaultValue(List<string> errors)
        {
            if (string.IsNullOrEmpty(DefaultValue)) {
                return;
            }

            if (DefaultValue.Length > MaxValueLength) {
                errors.Add($"Column '{Name}': {nameof(DefaultValue)} must not exceed {MaxValueLength} characters.");
            }
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
