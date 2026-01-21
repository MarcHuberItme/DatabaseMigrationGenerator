// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.Text.RegularExpressions;

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class ColumnSettings
    {
        public string Name { get; init; } = string.Empty;

        public string? Description { get; init; } = string.Empty;

        public long? MinValue { get; init; }

        public long? MaxValue { get; init; }

        public GenericControlsSettings? GenericControls { get; init; }

        private const int MaxNameLength = 30;
        private const int MaxDescriptionLength = 2000;
        private static readonly Regex AllowedNamePattern = new(@"^[a-zA-Z0-9]+$", RegexOptions.Compiled);
        private static readonly char[] NotAllowedDescriptionCharacters = ['ä', 'ö', 'ü', 'Ä', 'Ö', 'Ü', 'ß', 'é', 'è', 'à', 'ù', 'É', 'È', 'À', 'Ù'];

        public List<string> Validate()
        {
            var errors = new List<string>();

            ValidateName(errors);
            ValidateDescription(errors);
            ValidateGenericControls(errors);

            return errors;
        }

        private void ValidateName(List<string> errors)
        {
            if (string.IsNullOrEmpty(Name)) {
                errors.Add($"Column {nameof(Name)} is required.");
                return;
            }

            if (Name.Length > MaxNameLength) {
                errors.Add($"Column {nameof(Name)} must not exceed {MaxNameLength} characters.");
            }

            if (!char.IsUpper(Name[0])) {
                errors.Add($"Column {nameof(Name)} must start with an uppercase letter.");
            }

            if (!AllowedNamePattern.IsMatch(Name)) {
                errors.Add($"Column {nameof(Name)} must only contain letters (a-z, A-Z) and digits (0-9).");
            }
        }

        private void ValidateDescription(List<string> errors)
        {
            if (string.IsNullOrEmpty(Description)) {
                errors.Add($"Column {nameof(Description)} is required.");
                return;
            }

            if (Description.Length > MaxDescriptionLength) {
                errors.Add($"Column {nameof(Description)} must not exceed {MaxDescriptionLength} characters.");
            }

            if (!char.IsUpper(Description[0])) {
                errors.Add($"Column {nameof(Description)} must start with an uppercase letter.");
            }

            if (Description.IndexOfAny(NotAllowedDescriptionCharacters) >= 0) {
                errors.Add($"Column {nameof(Description)} must not contain umlauts.");
            }
        }

        private void ValidateGenericControls(List<string> errors)
        {
            if (GenericControls is null) {
                errors.Add($"Column {nameof(GenericControls)} is required.");
                return;
            }

            errors.AddRange(GenericControls.Validate());
        }
    }
}
