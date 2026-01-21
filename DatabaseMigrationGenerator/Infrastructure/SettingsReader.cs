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

        public async Task<(IEnumerable<ISettings> settings, int totalScanned)> ReadAsync(string migrationsPath, Action<int, int>? onProgress = null)
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

                if (content.StartsWith("table:"))
                {
                    try
                    {
                        var tableSettingsRoot = Deserializer.Deserialize<TableSettingsRoot>(content);
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
            });

            return (settings, totalFiles);
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