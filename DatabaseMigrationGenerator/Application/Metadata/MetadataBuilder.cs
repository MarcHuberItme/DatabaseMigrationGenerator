// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Application.Common;
using Finstar.DatabaseMigrationGenerator.Domain.HeaderTable;
using Finstar.DatabaseMigrationGenerator.Domain.Metadata;
using Finstar.DatabaseMigrationGenerator.Domain.SettingsObject;

namespace Finstar.DatabaseMigrationGenerator.Application.Metadata
{
    public class MetadataBuilder : IMetadataBuilder
    {
        public IEnumerable<IMetadata> Build(
            IEnumerable<ISettings> settings,
            IEnumerable<HeaderTableSettings> headerTableSettings)
        {
            var metaData = new List<IMetadata>();
            foreach (var setting in settings) {

                switch (setting) {
                    case TableSettings tableSettings:
                        var tableSetting = (TableSettings)setting;
                        EnsureTableNameNotEmpty(tableSetting.Name);
                        var tableId = tableSetting.Id;
                        if (!Guid.TryParse(tableId, out _))
                        {
                            tableId = GuidCreator.CreateDeterministicGuid(tableSetting.Name).ToString();
                        }

                        var tableMetaData = new TableMetadata(
                            tableId,
                            tableSetting.Name,
                            tableSetting.Description ?? string.Empty,
                            tableSetting.TableUsageNo,
                            tableSetting.DomainType,
                            tableSetting.HeaderTable,
                            tableSetting.WritableForEbanking);
                        
                        metaData.Add(tableMetaData);
                        break;
                    default:
                        
                        break;
                }
            }
            return metaData;
        }

        private static void EnsureTableNameNotEmpty(string? tableName)
        {
            if (string.IsNullOrEmpty(tableName)) {
                throw new ArgumentNullException(nameof(tableName), "Table name must be set");
            }
        }
    }
}