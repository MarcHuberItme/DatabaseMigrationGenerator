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

        public string? Id { get; init; } = string.Empty;

        public string? Description { get; init; } = string.Empty;

        public byte DomainType { get; init; }

        public string HeaderTable { get; init; } = string.Empty;

        public byte TableUsageNo { get; init; }

        public bool WritableForEbanking { get; init; } = false;

        // public GenericComponentsSettings? GenericComponents { get; set; } = new();
        // public List<TableColumnSettings>? Columns { get; set; } = new();

        private const int MaxNameLength = 30;
        private static readonly char[] Umlauts = ['ä', 'ö', 'ü', 'Ä', 'Ö', 'Ü', 'ß'];

        public override List<string> Validate()
        {
            var errors = new List<string>();

            if (string.IsNullOrEmpty(Name)) {
                errors.Add($"{nameof(Name)} is required.");
            } else {
                if (Name.Length > MaxNameLength) {
                    errors.Add($"{nameof(Name)} must not exceed {MaxNameLength} characters.");
                }

                if (!char.IsUpper(Name[0])) {
                    errors.Add($"{nameof(Name)} must start with an uppercase letter.");
                }

                if (Name.IndexOfAny(Umlauts) >= 0) {
                    errors.Add($"{nameof(Name)} must not contain umlauts.");
                }

                if (Name.Contains(' ')) {
                    errors.Add($"{nameof(Name)} must not contain spaces.");
                }
            }

            if (string.IsNullOrEmpty(Id) || !Guid.TryParse(Id, out var parsedGuid) || parsedGuid == Guid.Empty) {
                errors.Add($"{nameof(Id)} must be a valid non-empty GUID.");
            }

            return errors;
        }
    }
}