// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class FrontEndViewSettingsRoot
    {
        public ViewSettings View { get; init; } = new();

        public FrontEndViewSettings FrontendView { get; init; } = new();

        public List<FrontEndViewColumnSettings> Columns { get; init; } = [];
    }
}
