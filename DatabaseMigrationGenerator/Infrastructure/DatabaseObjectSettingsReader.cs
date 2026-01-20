// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain;
using Finstar.DatabaseMigrationGenerator.Domain.DatabaseObject;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class DatabaseObjectSettingsReader : IDatabaseObjectSettingsReader
    {
        private const string SettingsFilePattern = "Settings.yaml";
        
        public async Task<IEnumerable<IDatabaseObjectSettings>> ReadAsync(string migrationsPath)
        {
            var settingsFiles = Directory.GetFiles(migrationsPath, SettingsFilePattern, SearchOption.AllDirectories);

            foreach (var file in settingsFiles)
            {
                var content = await File.ReadAllTextAsync(file);
                var deserializer = new DeserializerBuilder()
                    .WithNamingConvention(CamelCaseNamingConvention.Instance)
                    .Build();
                
                if (content.StartsWith("table:"))
                {
                    var settings = deserializer.Deserialize<TableObjectSettings>(content);
                    // var headerTable = headerTableReader.Get(settings.Table.HeaderTable);
                    // yield return ConfigurationMapper.MapTable(settings.Table, headerTable?.Columns);
                }
                // else if (yamlContent.StartsWith("function:"))
                // {
                //     var settings = deserializer.Deserialize<SettingsYamlFunctionModel>(yamlContent);
                //     yield return ConfigurationMapper.MapFunction(settings.Function);
                // }
                // else if (yamlContent.StartsWith("view:"))
                // {
                //     var settings = deserializer.Deserialize<SettingsYamlViewModel>(yamlContent);
                //     if (settings.FrontendView != null)
                //     {
                //         var headerTable = headerTableReader.Get(settings.FrontendView.HeaderTable);
                //         yield return ConfigurationMapper.MapView(settings.View, settings.FrontendView, headerTable?.Columns);
                //     }
                //     else
                //     {
                //         yield return ConfigurationMapper.MapView(settings.View, settings.FrontendView);
                //     }
                // }
                // else if (yamlContent.StartsWith("storedProcedure:"))
                // {
                //     var settings = deserializer.Deserialize<SettingsYamlStoredProcedureModel>(yamlContent);
                //     yield return ConfigurationMapper.MapStoredProcedure(settings.StoredProcedure);
                // }
            }
            
            return new List<IDatabaseObjectSettings> {
                new TableObjectSettings()
            };
        }
    }
}