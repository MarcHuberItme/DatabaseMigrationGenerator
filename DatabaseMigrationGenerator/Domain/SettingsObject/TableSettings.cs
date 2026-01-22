// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

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

        public static bool IsValidDomainType(byte domainType) => ValidDomainTypes.Contains(domainType);
        public static bool IsValidHeaderTable(string headerTable) => ValidHeaderTables.Contains(headerTable, StringComparer.OrdinalIgnoreCase);

        public static string GetValidDomainTypesString() => string.Join(", ", ValidDomainTypes);
        public static string GetValidHeaderTablesString() => string.Join(", ", ValidHeaderTables);

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
            if (!ValidDomainTypes.Contains(DomainType)) {
                errors.Add($"{nameof(DomainType)} must be one of: {string.Join(", ", ValidDomainTypes)}.");
            }
        }

        private void ValidateHeaderTable(List<string> errors)
        {
            if (string.IsNullOrEmpty(HeaderTable)) {
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
