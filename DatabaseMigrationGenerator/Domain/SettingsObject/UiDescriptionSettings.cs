// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class UiDescriptionSettings
    {
        public string FormTitle { get; init; } = string.Empty;

        public string HelpText { get; init; } = string.Empty;
    }

    public class UiTableDescriptionSettings
    {
        public UiDescriptionSettings? English { get; init; }

        public UiDescriptionSettings? German { get; init; }

        public UiDescriptionSettings? French { get; init; }

        public UiDescriptionSettings? Italian { get; init; }
    }
}
