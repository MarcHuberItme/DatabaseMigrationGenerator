// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public class GenericControlsSettings
    {
        public bool MultiLine { get; init; } = false;

        public string RefTable { get; init; } = string.Empty;

        public string RefField { get; init; } = string.Empty;

        public bool HasDetailBtn { get; init; } = false;

        public byte VisNumber { get; init; }

        public int? DefSizeX { get; init; }

        public int? DefSizeY { get; init; }

        public int? DefPosX { get; init; }

        public int? DefPosY { get; init; }

        public int? TabOrder { get; init; }

        public int DefColumnPos { get; init; } = 0;

        public int? DefColumnWidth { get; init; }

        public int NoUpdatePos { get; init; } = 0;

        public bool IsOnlyForMig { get; init; } = false;

        public bool IsNoUpdate { get; init; } = false;

        public bool IsIdentity { get; init; } = false;

        public List<string> Validate()
        {
            var errors = new List<string>();
            return errors;
        }
    }
}
