// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class GenericComponentsSettings
    {
        public byte? TableType { get; init; }

        public string GroupId { get; init; } = string.Empty;

        public bool DefArchive { get; init; } = true;

        public byte VisumNumber { get; init; }

        public byte? VisumLevel { get; init; }

        public bool HasAsText { get; init; } = true;

        public byte? CacheLevel { get; init; }

        public bool PhysicalDelete { get; init; } = false;

        public bool IsGroupable { get; init; } = false;

        public string DescField { get; init; } = string.Empty;

        public NavigationSettings? Navigation { get; init; }

        public byte ChangeNoticeLevel { get; init; }

        public List<UiTableDescriptionSettings>? UiTableDescription { get; init; }

        private static byte[] ValidTableTypes { get; set; } = [];
        private static byte[] ValidVisumLevels { get; set; } = [];
        private static byte[] ValidCacheLevels { get; set; } = [];
        private static string[] ValidGroupIds { get; set; } = [];

        public static void SetValidTableTypes(byte[] validTableTypes)
        {
            ValidTableTypes = validTableTypes;
        }

        public static void SetValidVisumLevels(byte[] validVisumLevels)
        {
            ValidVisumLevels = validVisumLevels;
        }

        public static void SetValidCacheLevels(byte[] validCacheLevels)
        {
            ValidCacheLevels = validCacheLevels;
        }

        public static void SetValidGroupIds(string[] validGroupIds)
        {
            ValidGroupIds = validGroupIds;
        }

        private static readonly byte[] ValidVisumNumbers = [0, 1, 85];

        public List<string> Validate(IEnumerable<string> validColumnNames)
        {
            var errors = new List<string>();

            ValidateTableType(errors);
            ValidateGroupId(errors);
            ValidateVisumNumber(errors);
            ValidateVisumLevel(errors);
            ValidateCacheLevel(errors);
            ValidateNavigation(errors);
            ValidateDescField(errors, validColumnNames);

            return errors;
        }

        private void ValidateTableType(List<string> errors)
        {
            if (TableType is null) {
                errors.Add($"{nameof(TableType)} is required.");
                return;
            }

            if (!ValidTableTypes.Contains(TableType.Value)) {
                errors.Add($"{nameof(TableType)} must be one of: {string.Join(", ", ValidTableTypes)}.");
            }
        }

        private void ValidateGroupId(List<string> errors)
        {
            if (string.IsNullOrEmpty(GroupId)) {
                errors.Add($"{nameof(GroupId)} is required.");
                return;
            }

            if (!ValidGroupIds.Contains(GroupId, StringComparer.OrdinalIgnoreCase)) {
                errors.Add($"{nameof(GroupId)} must be a valid group GUID.");
            }
        }

        private void ValidateVisumNumber(List<string> errors)
        {
            if (!ValidVisumNumbers.Contains(VisumNumber)) {
                errors.Add($"{nameof(VisumNumber)} must be one of: {string.Join(", ", ValidVisumNumbers)}.");
            }
        }

        private void ValidateVisumLevel(List<string> errors)
        {
            if (VisumLevel is null) {
                errors.Add($"{nameof(VisumLevel)} is required.");
                return;
            }

            if (!ValidVisumLevels.Contains(VisumLevel.Value)) {
                errors.Add($"{nameof(VisumLevel)} must be one of: {string.Join(", ", ValidVisumLevels)}.");
            }
        }

        private void ValidateCacheLevel(List<string> errors)
        {
            if (CacheLevel is null) {
                errors.Add($"{nameof(CacheLevel)} is required.");
                return;
            }

            if (!ValidCacheLevels.Contains(CacheLevel.Value)) {
                errors.Add($"{nameof(CacheLevel)} must be one of: {string.Join(", ", ValidCacheLevels)}.");
            }
        }

        private void ValidateNavigation(List<string> errors)
        {
            if (Navigation is null) {
                return;
            }

            errors.AddRange(Navigation.Validate());
        }

        private void ValidateDescField(List<string> errors, IEnumerable<string> validColumnNames)
        {
            if (string.IsNullOrEmpty(DescField)) {
                return;
            }

            if (DescField.StartsWith(';')) {
                errors.Add($"{nameof(DescField)} must not start with a semicolon.");
            }

            if (DescField.EndsWith(';')) {
                errors.Add($"{nameof(DescField)} must not end with a semicolon.");
            }

            var descFieldNames = DescField.Split(';', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);
            var validNames = validColumnNames.ToHashSet(StringComparer.OrdinalIgnoreCase);

            foreach (var fieldName in descFieldNames) {
                if (!validNames.Contains(fieldName)) {
                    errors.Add($"{nameof(DescField)} contains invalid column reference '{fieldName}'. Must be a valid column name.");
                }
            }
        }
    }
}
