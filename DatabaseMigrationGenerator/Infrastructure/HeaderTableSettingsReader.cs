// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.HeaderTable;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class HeaderTableSettingsReader : IHeaderTableSettingsReader
    {
        private const string HeaderTablesFileName = "HeaderTables.yaml";
        
        public async Task<IEnumerable<HeaderTableSettings>> ReadAsync(string migrationsPath)
        {
            var headerTablesFilePath = Path.Combine(migrationsPath, HeaderTablesFileName);

            if (!File.Exists(headerTablesFilePath)) {
                return [];
            }

            var content = await File.ReadAllTextAsync(headerTablesFilePath);
            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .IgnoreUnmatchedProperties()
                .Build();

            var headerTableObjects = deserializer.Deserialize<HeaderTableSettingsRoot>(content);
            // var headerTableItem = headerTableObjects.HeaderTables.FirstOrDefault(item => item.Type == headerTable);
            // if (headerTableItem != null)
            // {
            //     headerTables.Add(headerTable, headerTableItem);
            // }

            return [];
        }
    }
}