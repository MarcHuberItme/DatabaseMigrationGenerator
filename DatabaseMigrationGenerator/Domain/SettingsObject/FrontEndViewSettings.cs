// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

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

        public override List<string> Validate()
        {
            var errors = new List<string>();

            SettingsValidators.ValidateName(errors, Name, MaxNameLength);
            SettingsValidators.ValidateDescription(errors, Description);
            ValidateTableUsageNo(errors);
            ValidateDomainType(errors);
            ValidateHeaderTable(errors);
            ValidateGenericComponents(errors);
            ValidateColumns(errors);

            return errors;
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
