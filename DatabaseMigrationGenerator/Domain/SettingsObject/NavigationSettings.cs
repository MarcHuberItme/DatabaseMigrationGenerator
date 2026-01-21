// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class NavigationSettings
    {
        public bool? IsNavigationRoot { get; init; }

        public string RootTable { get; init; } = string.Empty;

        public string ParentTable { get; init; } = string.Empty;

        public string ParentIdField { get; init; } = string.Empty;

        public string ParentRelationField { get; init; } = string.Empty;

        public string ApplicationKey { get; init; } = string.Empty;

        public string NavigationConditionField { get; init; } = string.Empty;

        public bool? IsSharedNode { get; init; }

        public bool? IsHiddenNode { get; init; }

        public List<string> Validate()
        {
            var errors = new List<string>();

            if (IsNavigationRoot is null) {
                errors.Add($"{nameof(IsNavigationRoot)} is required.");
            }

            if (IsSharedNode is null) {
                errors.Add($"{nameof(IsSharedNode)} is required.");
            }

            if (IsHiddenNode is null) {
                errors.Add($"{nameof(IsHiddenNode)} is required.");
            }

            return errors;
        }
    }
}
