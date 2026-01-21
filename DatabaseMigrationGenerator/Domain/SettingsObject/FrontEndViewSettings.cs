// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.Text.RegularExpressions;

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class FrontEndViewSettings() : SettingsBase
    {
        public string Name { get; init; } = string.Empty;

        public string? Description { get; init; } = string.Empty;

        public byte DomainType { get; init; }

        public string HeaderTable { get; init; } = string.Empty;

        public byte TableUsageNo { get; init; }

        public FrontEndViewGenericComponentsSettings? GenericComponents { get; init; }

        public List<FrontEndViewColumnSettings> Columns { get; init; } = [];

        private const int MaxNameLength = 30;
        private const int MaxDescriptionLength = 2000;
        private static readonly Regex AllowedNamePattern = new(@"^[a-zA-Z0-9_]+$", RegexOptions.Compiled);

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

        private void ValidateTableUsageNo(List<string> errors)
        {
            if (TableUsageNo != 1) {
                errors.Add($"{nameof(TableUsageNo)} must be 1.");
            }
        }

        private void ValidateDomainType(List<string> errors)
        {
            if (!TableSettings.IsValidDomainType(DomainType)) {
                errors.Add($"{nameof(DomainType)} must be one of: {TableSettings.GetValidDomainTypesString()}.");
            }
        }

        private void ValidateHeaderTable(List<string> errors)
        {
            if (string.IsNullOrEmpty(HeaderTable)) {
                return;
            }

            if (!TableSettings.IsValidHeaderTable(HeaderTable)) {
                errors.Add($"{nameof(HeaderTable)} must be one of: {TableSettings.GetValidHeaderTablesString()}.");
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
