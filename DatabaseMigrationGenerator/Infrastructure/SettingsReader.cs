// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.SettingsObject;
using YamlDotNet.Core;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class SettingsReader : ISettingsReader
    {
        private const string SettingsFilePattern = "Settings.yaml";
        
        public async Task<IEnumerable<ISettings>> ReadAsync(string migrationsPath)
        {
            var settingsFiles = Directory.GetFiles(migrationsPath, SettingsFilePattern, SearchOption.AllDirectories);

            var settings = new List<ISettings>();
            
            foreach (var file in settingsFiles)
            {
                var content = await File.ReadAllTextAsync(file);
                var deserializer = new DeserializerBuilder()
                    .WithNamingConvention(CamelCaseNamingConvention.Instance)
                    .IgnoreUnmatchedProperties()
                    .Build();
                
                if (content.StartsWith("table:"))
                {
                    try
                    {
                        var tableSettingsRoot = deserializer.Deserialize<TableSettingsRoot>(content);
                        var tableSettings = tableSettingsRoot.Table;
                        tableSettings.MapSourceFilePath(file);
                        tableSettings.Columns.AddRange(tableSettingsRoot.Columns);
                        settings.Add(tableSettings);
                    }
                    catch (YamlException ex)
                    {
                        throw new InvalidOperationException(
                            $"Error deserializing '{file}': {GetDeserializationErrorMessage(ex)}", ex);
                    }
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
            
            return settings;
        }

        private static string GetDeserializationErrorMessage(YamlException ex)
        {
            var innerMessage = ex.InnerException?.Message ?? ex.Message;

            if (innerMessage.Contains("Boolean") || innerMessage.Contains("bool"))
            {
                return $"Invalid value at line {ex.Start.Line}. Expected a boolean value (true or false).";
            }

            if (innerMessage.Contains("Int") || innerMessage.Contains("Byte"))
            {
                return $"Invalid value at line {ex.Start.Line}. Expected a numeric value.";
            }

            return $"Invalid value at line {ex.Start.Line}: {innerMessage}";
        }
    }
}