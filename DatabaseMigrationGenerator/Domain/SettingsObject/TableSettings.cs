// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.Text.RegularExpressions;

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class TableSettings() : SettingsBase
    {
        public string Name { get; init; } = string.Empty;

        public string? Description { get; init; } = string.Empty;

        public byte DomainType { get; init; }

        public string HeaderTable { get; init; } = string.Empty;

        public byte TableUsageNo { get; init; }

        public bool WritableForEbanking { get; init; } = false;

        public GenericComponentsSettings? GenericComponents { get; init; }

        public List<ColumnSettings> Columns { get; init; } = [];

        private const int MaxNameLength = 30;
        private const int MaxDescriptionLength = 2000;
        private static readonly Regex AllowedNamePattern = new(@"^[a-zA-Z0-9]+$", RegexOptions.Compiled);
        private static readonly char[] NotAllowedDescriptionCharacters = ['ä', 'ö', 'ü', 'Ä', 'Ö', 'Ü', 'ß', 'é', 'è', 'à', 'ù', 'É', 'È', 'À', 'Ù'];
        private static byte[] ValidDomainTypes { get; set; } = [];
        private static string[] ValidHeaderTables { get; set; } = [];

        public static void SetValidDomainTypes(byte[] validDomainTypes)
        {
            ValidDomainTypes = validDomainTypes;
        }

        public static void SetValidHeaderTables(string[] validHeaderTables)
        {
            ValidHeaderTables = validHeaderTables;
        }

        public override List<string> Validate()
        {
            var errors = new List<string>();

            ValidateName(errors);
            ValidateDescription(errors);
            ValidateTableUsageNo(errors);
            ValidateDomainType(errors);
            ValidateHeaderTable(errors);
            ValidateGenericComponents(errors);
            ValidateColumns(errors);

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

            if (!char.IsUpper(Name[0])) {
                errors.Add($"{nameof(Name)} must start with an uppercase letter.");
            }

            if (!AllowedNamePattern.IsMatch(Name)) {
                errors.Add($"{nameof(Name)} must only contain letters (a-z, A-Z) and digits (0-9).");
            }
        }

        private void ValidateDescription(List<string> errors)
        {
            if (string.IsNullOrEmpty(Description)) {
                errors.Add($"{nameof(Description)} is required.");
                return;
            }

            if (Description.Length > MaxDescriptionLength) {
                errors.Add($"{nameof(Description)} must not exceed {MaxDescriptionLength} characters.");
            }

            if (!char.IsUpper(Description[0])) {
                errors.Add($"{nameof(Description)} must start with an uppercase letter.");
            }

            if (Description.IndexOfAny(NotAllowedDescriptionCharacters) >= 0) {
                errors.Add($"{nameof(Description)} must not contain umlauts.");
            }
        }

        private void ValidateTableUsageNo(List<string> errors)
        {
            if (TableUsageNo != 1) {
                errors.Add($"{nameof(TableUsageNo)} must be 1.");
            }
        }

        private void ValidateDomainType(List<string> errors)
        {
            if (!ValidDomainTypes.Contains(DomainType)) {
                errors.Add($"{nameof(DomainType)} must be one of: {string.Join(", ", ValidDomainTypes)}.");
            }
        }

        private void ValidateHeaderTable(List<string> errors)
        {
            if (string.IsNullOrEmpty(HeaderTable)) {
                errors.Add($"{nameof(HeaderTable)} is required.");
                return;
            }

            if (!ValidHeaderTables.Contains(HeaderTable, StringComparer.OrdinalIgnoreCase)) {
                errors.Add($"{nameof(HeaderTable)} must be one of: {string.Join(", ", ValidHeaderTables)}.");
            }
        }

        private void ValidateGenericComponents(List<string> errors)
        {
            if (GenericComponents is null) {
                errors.Add($"{nameof(GenericComponents)} is required.");
                return;
            }

            var columnNames = Columns.Select(c => c.Name).ToList();
            errors.AddRange(GenericComponents.Validate(columnNames));
        }

        private void ValidateColumns(List<string> errors)
        {
            foreach (var column in Columns) {
                errors.AddRange(column.Validate());
            }
        }
    }
}