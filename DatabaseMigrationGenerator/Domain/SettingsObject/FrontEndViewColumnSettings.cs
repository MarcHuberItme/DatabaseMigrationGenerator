// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class FrontEndViewColumnSettings : ColumnSettingsBase
    {
        public string? DataType { get; init; }

        public bool IsNotNull { get; init; }

        public bool IsUnique { get; init; }

        public int Prec { get; init; }

        public int Scale { get; init; }

        public override GenericControlsSettings? GenericControls { get; init; }
    }
}
