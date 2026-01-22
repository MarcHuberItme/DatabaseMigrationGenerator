// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.ComponentModel.DataAnnotations;
using Finstar.DatabaseMigrationGenerator.Application.Output;
using Finstar.DatabaseMigrationGenerator.Domain.HeaderTable;
using Finstar.DatabaseMigrationGenerator.Domain.Metadata;
using Finstar.DatabaseMigrationGenerator.Domain.SettingsObject;
using Finstar.DatabaseMigrationGenerator.Infrastructure;

namespace Finstar.DatabaseMigrationGenerator.Application.Metadata
{
    public class MetadataGenerationService(
        IConsoleOutput console,
        ISettingsReader settingsReader,
        IHeaderTableSettingsReader headerTableSettingsReader,
        IMdDomainTypeReader mdDomainTypeReader,
        IMdTableTypeReader mdTableTypeReader,
        IMdVisumLevelReader mdVisumLevelReader,
        IMdCacheLevelReader mdCacheLevelReader,
        IMdGroupReader mdGroupReader,
        IMetadataBuilder metadataBuilder) : IMetadataGenerationService
    {
        public async Task<IEnumerable<IMetadata>> Generate(string migrationsPath)
        {
            var headerTableSettings = await LoadConfigurationAsync(migrationsPath);
            var settings = await ReadSettingsAsync(migrationsPath);

            ValidateSettings(settings);

            console.WriteSuccess($"{settings.Count:N0} Settings.yaml files loaded and validated successfully!");

            return metadataBuilder.Build(settings, headerTableSettings);
        }

        private async Task<List<HeaderTableSettings>> LoadConfigurationAsync(string migrationsPath)
        {
            console.Write("Loading configuration...");

            await LoadDomainTypesAsync(migrationsPath);
            await LoadTableTypesAsync(migrationsPath);
            await LoadVisumLevelsAsync(migrationsPath);
            await LoadCacheLevelsAsync(migrationsPath);
            await LoadGroupIdsAsync(migrationsPath);
            var headerTableSettings = await LoadHeaderTablesAsync(migrationsPath);

            console.WriteLine(" done");
            return headerTableSettings;
        }

        private async Task LoadDomainTypesAsync(string migrationsPath)
        {
            var validDomainTypes = await mdDomainTypeReader.ReadAsync(migrationsPath);
            TableSettings.SetValidDomainTypes(validDomainTypes);
        }

        private async Task LoadTableTypesAsync(string migrationsPath)
        {
            var validTableTypes = await mdTableTypeReader.ReadAsync(migrationsPath);
            GenericComponentsSettings.SetValidTableTypes(validTableTypes);
        }

        private async Task LoadVisumLevelsAsync(string migrationsPath)
        {
            var validVisumLevels = await mdVisumLevelReader.ReadAsync(migrationsPath);
            GenericComponentsSettings.SetValidVisumLevels(validVisumLevels);
        }

        private async Task LoadCacheLevelsAsync(string migrationsPath)
        {
            var validCacheLevels = await mdCacheLevelReader.ReadAsync(migrationsPath);
            GenericComponentsSettings.SetValidCacheLevels(validCacheLevels);
        }

        private async Task LoadGroupIdsAsync(string migrationsPath)
        {
            var validGroupIds = await mdGroupReader.ReadAsync(migrationsPath);
            GenericComponentsSettings.SetValidGroupIds(validGroupIds);
        }

        private async Task<List<HeaderTableSettings>> LoadHeaderTablesAsync(string migrationsPath)
        {
            var headerTableSettings = (await headerTableSettingsReader.ReadAsync(migrationsPath)).ToList();
            var validHeaderTables = headerTableSettings.Select(h => h.Type).ToArray();
            TableSettings.SetValidHeaderTables(validHeaderTables);
            return headerTableSettings;
        }

        private async Task<List<ISettings>> ReadSettingsAsync(string migrationsPath)
        {
            var settingsEnumerable = await settingsReader.ReadAsync(migrationsPath, (current, total) =>
            {
                console.WriteProgress($"Reading settings files... {current}/{total}");
            });
            var settings = settingsEnumerable.ToList();
            console.WriteLine(" done");
            return settings;
        }

        private void ValidateSettings(List<ISettings> settings)
        {
            console.Write("Validating settings...");

            var allErrors = CollectValidationErrors(settings);

            if (allErrors.Count > 0)
            {
                ReportValidationErrors(allErrors);
                throw new ValidationException(
                    $"Settings.yaml validation failed with {allErrors.Sum(e => e.Errors.Count)} error(s) " +
                    $"in {allErrors.Count} of {settings.Count} file(s).");
            }

            console.WriteLine(" done");
        }

        private static List<(ISettings Setting, List<string> Errors)> CollectValidationErrors(List<ISettings> settings)
        {
            var allErrors = new List<(ISettings Setting, List<string> Errors)>();

            foreach (var setting in settings)
            {
                var errors = setting.Validate();
                if (errors.Count > 0)
                {
                    allErrors.Add((setting, errors));
                }
            }

            return allErrors;
        }

        private void ReportValidationErrors(List<(ISettings Setting, List<string> Errors)> allErrors)
        {
            console.WriteLine();
            console.WriteLine("Validation errors found:");
            console.WriteLine();

            foreach (var (setting, errors) in allErrors)
            {
                console.WriteLine($"  {setting.SourceFilePath}:");
                foreach (var error in errors)
                {
                    console.WriteError($"    - {error}");
                }
                console.WriteLine();
            }
        }
    }
}
