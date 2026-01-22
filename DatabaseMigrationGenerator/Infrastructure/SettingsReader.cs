// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.Collections.Concurrent;
using Finstar.DatabaseMigrationGenerator.Domain.SettingsObject;
using YamlDotNet.Core;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class SettingsReader : ISettingsReader
    {
        private const string SettingsFilePattern = "Settings.yaml";

        private static readonly IDeserializer Deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .IgnoreUnmatchedProperties()
            .Build();

        public async Task<IEnumerable<ISettings>> ReadAsync(string migrationsPath, Action<int, int>? onProgress = null)
        {
            var settingsFiles = Directory.GetFiles(migrationsPath, SettingsFilePattern, SearchOption.AllDirectories);
            var totalFiles = settingsFiles.Length;

            var settings = new ConcurrentBag<ISettings>();
            var currentFile = 0;
            var lastReported = 0;
            var progressLock = new object();

            var parallelOptions = new ParallelOptions { MaxDegreeOfParallelism = Environment.ProcessorCount };

            await Parallel.ForEachAsync(settingsFiles, parallelOptions, async (file, cancellationToken) =>
            {
                var current = Interlocked.Increment(ref currentFile);

                if (onProgress != null && (current - lastReported >= 100 || current == totalFiles))
                {
                    lock (progressLock)
                    {
                        if (current - lastReported >= 100 || current == totalFiles)
                        {
                            lastReported = current;
                            onProgress(current, totalFiles);
                        }
                    }
                }

                var content = await File.ReadAllTextAsync(file, cancellationToken);

                try
                {
                    if (content.StartsWith("table:"))
                    {
                        var tableSettingsRoot = Deserializer.Deserialize<TableSettingsRoot>(content);
                        var tableSettings = tableSettingsRoot.Table;
                        tableSettings.MapSourceFilePath(file);
                        tableSettings.Columns.AddRange(tableSettingsRoot.Columns);
                        settings.Add(tableSettings);
                    }
                    else if (content.StartsWith("view:") && content.Contains("frontendView:"))
                    {
                        var frontEndViewSettingsRoot = Deserializer.Deserialize<FrontEndViewSettingsRoot>(content);
                        var frontEndViewSettings = frontEndViewSettingsRoot.FrontendView;
                        frontEndViewSettings.MapSourceFilePath(file);
                        frontEndViewSettings.Columns.AddRange(frontEndViewSettingsRoot.Columns);
                        settings.Add(frontEndViewSettings);
                    }
                    else if (content.StartsWith("view:"))
                    {
                        var viewSettingsRoot = Deserializer.Deserialize<ViewSettingsRoot>(content);
                        var viewSettings = viewSettingsRoot.View;
                        viewSettings.MapSourceFilePath(file);
                        settings.Add(viewSettings);
                    }
                    else if (content.StartsWith("storedProcedure:"))
                    {
                        var storedProcedureSettingsRoot = Deserializer.Deserialize<StoredProcedureSettingsRoot>(content);
                        var storedProcedureSettings = storedProcedureSettingsRoot.StoredProcedure;
                        storedProcedureSettings.MapSourceFilePath(file);
                        settings.Add(storedProcedureSettings);
                    }
                    else if (content.StartsWith("function:"))
                    {
                        var functionSettingsRoot = Deserializer.Deserialize<FunctionSettingsRoot>(content);
                        var functionSettings = functionSettingsRoot.Function;
                        functionSettings.MapSourceFilePath(file);
                        settings.Add(functionSettings);
                    }
                }
                catch (YamlException ex)
                {
                    throw new InvalidOperationException(
                        $"Error deserializing '{file}': {GetDeserializationErrorMessage(ex)}", ex);
                }
            });

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