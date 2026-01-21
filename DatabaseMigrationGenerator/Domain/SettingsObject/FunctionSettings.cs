// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.Text.RegularExpressions;

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class FunctionSettings() : SettingsBase
    {
        public string Name { get; init; } = string.Empty;

        public string? Description { get; init; } = string.Empty;

        private const int MaxNameLength = 128;
        private const int MaxDescriptionLength = 2000;
        private static readonly Regex AllowedNamePattern = new(@"^[a-zA-Z0-9_]+$", RegexOptions.Compiled);

        public override List<string> Validate()
        {
            var errors = new List<string>();

            ValidateName(errors);
            ValidateDescription(errors);

            return errors;
        }

        private void ValidateName(List<string> errors)
        {
            if (string.IsNullOrEmpty(Name)) {
                errors.Add($"{nameof(Name)} is required.");
                return;
            }

            if (Name.Length > MaxNameLength) {
                errors.Add($"{nameof(Name)} must not exceed {MaxNameLength} characters.");
            }

            if (!AllowedNamePattern.IsMatch(Name)) {
                errors.Add($"{nameof(Name)} must only contain letters (a-z, A-Z), digits (0-9), and underscores (_).");
            }
        }

        private void ValidateDescription(List<string> errors)
        {
            if (string.IsNullOrEmpty(Description)) {
                return;
            }

            if (Description.Length > MaxDescriptionLength) {
                errors.Add($"{nameof(Description)} must not exceed {MaxDescriptionLength} characters.");
            }
        }
    }
}
