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
        private const int ProgressReportInterval = 100;

        private static readonly IDeserializer Deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .IgnoreUnmatchedProperties()
            .Build();

        public async Task<IEnumerable<ISettings>> ReadAsync(string migrationsPath, Action<int, int>? onProgress = null)
        {
            var settingsFiles = Directory.GetFiles(migrationsPath, SettingsFilePattern, SearchOption.AllDirectories);
            var settings = new ConcurrentBag<ISettings>();
            var progressTracker = new ProgressTracker(settingsFiles.Length, onProgress);

            await ProcessFilesInParallelAsync(settingsFiles, settings, progressTracker);

            return settings;
        }

        private static async Task ProcessFilesInParallelAsync(
            string[] files,
            ConcurrentBag<ISettings> settings,
            ProgressTracker progressTracker)
        {
            var parallelOptions = new ParallelOptions { MaxDegreeOfParallelism = Environment.ProcessorCount };

            await Parallel.ForEachAsync(files, parallelOptions, async (file, cancellationToken) =>
            {
                progressTracker.ReportProgress();
                var parsedSettings = await ParseSettingsFileAsync(file, cancellationToken);
                if (parsedSettings != null)
                {
                    settings.Add(parsedSettings);
                }
            });
        }

        private static async Task<ISettings?> ParseSettingsFileAsync(string file, CancellationToken cancellationToken)
        {
            var content = await File.ReadAllTextAsync(file, cancellationToken);

            try
            {
                return ParseSettingsContent(content, file);
            }
            catch (YamlException ex)
            {
                throw new InvalidOperationException(
                    $"Error deserializing '{file}': {FormatYamlErrorMessage(ex)}", ex);
            }
        }

        private static ISettings? ParseSettingsContent(string content, string filePath)
        {
            if (content.StartsWith("table:"))
                return ParseTableSettings(content, filePath);

            if (content.StartsWith("view:") && content.Contains("frontendView:"))
                return ParseFrontEndViewSettings(content, filePath);

            if (content.StartsWith("view:"))
                return ParseViewSettings(content, filePath);

            if (content.StartsWith("storedProcedure:"))
                return ParseStoredProcedureSettings(content, filePath);

            if (content.StartsWith("function:"))
                return ParseFunctionSettings(content, filePath);

            return null;
        }

        private static TableSettings ParseTableSettings(string content, string filePath)
        {
            var root = Deserializer.Deserialize<TableSettingsRoot>(content);
            var settings = root.Table;
            settings.MapSourceFilePath(filePath);
            settings.Columns.AddRange(root.Columns);
            return settings;
        }

        private static FrontEndViewSettings ParseFrontEndViewSettings(string content, string filePath)
        {
            var root = Deserializer.Deserialize<FrontEndViewSettingsRoot>(content);
            var settings = root.FrontendView;
            settings.MapSourceFilePath(filePath);
            settings.Columns.AddRange(root.Columns);
            return settings;
        }

        private static ViewSettings ParseViewSettings(string content, string filePath)
        {
            var root = Deserializer.Deserialize<ViewSettingsRoot>(content);
            var settings = root.View;
            settings.MapSourceFilePath(filePath);
            return settings;
        }

        private static StoredProcedureSettings ParseStoredProcedureSettings(string content, string filePath)
        {
            var root = Deserializer.Deserialize<StoredProcedureSettingsRoot>(content);
            var settings = root.StoredProcedure;
            settings.MapSourceFilePath(filePath);
            return settings;
        }

        private static FunctionSettings ParseFunctionSettings(string content, string filePath)
        {
            var root = Deserializer.Deserialize<FunctionSettingsRoot>(content);
            var settings = root.Function;
            settings.MapSourceFilePath(filePath);
            return settings;
        }

        private static string FormatYamlErrorMessage(YamlException ex)
        {
            var innerMessage = ex.InnerException?.Message ?? ex.Message;

            if (innerMessage.Contains("Boolean") || innerMessage.Contains("bool"))
                return $"Invalid value at line {ex.Start.Line}. Expected a boolean value (true or false).";

            if (innerMessage.Contains("Int") || innerMessage.Contains("Byte"))
                return $"Invalid value at line {ex.Start.Line}. Expected a numeric value.";

            return $"Invalid value at line {ex.Start.Line}: {innerMessage}";
        }

        private class ProgressTracker(int totalFiles, Action<int, int>? onProgress)
        {
            private int _currentFile;
            private int _lastReported;
            private readonly object _lock = new();

            public void ReportProgress()
            {
                if (onProgress == null) return;

                var current = Interlocked.Increment(ref _currentFile);
                if (current - _lastReported < ProgressReportInterval && current != totalFiles) return;

                lock (_lock)
                {
                    if (current - _lastReported < ProgressReportInterval && current != totalFiles) return;
                    _lastReported = current;
                    onProgress(current, totalFiles);
                }
            }
        }
    }
}