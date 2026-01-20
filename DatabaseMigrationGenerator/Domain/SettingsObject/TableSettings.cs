// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.ComponentModel.DataAnnotations;

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

        public override void Validate()
        {
            if (string.IsNullOrEmpty(Name)) {
                throw new ValidationException($"{nameof(Name)} is required.");
            }

            //now validate and throw if not ok
           
        }
    }
}