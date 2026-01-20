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

        private static byte[] ValidTableTypes { get; set; } = [];

        public static void SetValidTableTypes(byte[] validTableTypes)
        {
            ValidTableTypes = validTableTypes;
        }

        public List<string> Validate()
        {
            var errors = new List<string>();

            ValidateTableType(errors);

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
    }
}
