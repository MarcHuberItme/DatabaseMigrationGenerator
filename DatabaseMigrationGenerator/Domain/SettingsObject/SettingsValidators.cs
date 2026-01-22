// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.Text.RegularExpressions;

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public static class SettingsValidators
    {
        private static readonly Regex AllowedNamePattern = new(@"^[a-zA-Z0-9_]+$", RegexOptions.Compiled);

        public static void ValidateName(List<string> errors, string? name, int maxLength, string? prefix = null)
        {
            var fieldName = prefix is null ? "Name" : $"{prefix} Name";

            if (string.IsNullOrEmpty(name)) {
                errors.Add($"{fieldName} is required.");
                return;
            }

            if (name.Length > maxLength) {
                errors.Add($"{fieldName} must not exceed {maxLength} characters.");
            }

            if (!AllowedNamePattern.IsMatch(name)) {
                errors.Add($"{fieldName} must only contain letters (a-z, A-Z), digits (0-9), and underscores (_).");
            }
        }

        public static void ValidateDescription(List<string> errors, string? description, int maxLength = 2000, string? prefix = null)
        {
            if (string.IsNullOrEmpty(description)) {
                return;
            }

            var fieldName = prefix is null ? "Description" : $"{prefix} Description";

            if (description.Length > maxLength) {
                errors.Add($"{fieldName} must not exceed {maxLength} characters.");
            }
        }

        public static void ValidateStringField(List<string> errors, string? value, string fieldName, int maxLength)
        {
            if (string.IsNullOrEmpty(value)) {
                return;
            }

            if (value.Length > maxLength) {
                errors.Add($"{fieldName} must not exceed {maxLength} characters.");
            }
        }
    }
}
