// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.ComponentModel.DataAnnotations;
using Finstar.DatabaseMigrationGenerator.Application.Output;
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
            console.Write("Loading configuration...");
            var validDomainTypes = await mdDomainTypeReader.ReadAsync(migrationsPath);
            TableSettings.SetValidDomainTypes(validDomainTypes);

            var validTableTypes = await mdTableTypeReader.ReadAsync(migrationsPath);
            GenericComponentsSettings.SetValidTableTypes(validTableTypes);

            var validVisumLevels = await mdVisumLevelReader.ReadAsync(migrationsPath);
            GenericComponentsSettings.SetValidVisumLevels(validVisumLevels);

            var validCacheLevels = await mdCacheLevelReader.ReadAsync(migrationsPath);
            GenericComponentsSettings.SetValidCacheLevels(validCacheLevels);

            var validGroupIds = await mdGroupReader.ReadAsync(migrationsPath);
            GenericComponentsSettings.SetValidGroupIds(validGroupIds);

            var headerTableSettings = await headerTableSettingsReader.ReadAsync(migrationsPath);
            var validHeaderTables = headerTableSettings.Select(h => h.Type).ToArray();
            TableSettings.SetValidHeaderTables(validHeaderTables);
            console.WriteLine(" done");

            var settingsEnumerable = await settingsReader.ReadAsync(migrationsPath, (current, total) =>
            {
                console.WriteProgress($"Reading settings files... {current}/{total}");
            });
            var settings = settingsEnumerable.ToList();
            console.WriteLine(" done");

            console.Write("Validating settings...");
            var allErrors = new List<(ISettings Setting, List<string> Errors)>();
            foreach (var setting in settings) {
                var errors = setting.Validate();
                if (errors.Count > 0) {
                    allErrors.Add((setting, errors));
                }
            }

            if (allErrors.Count > 0) {
                console.WriteLine();
                console.WriteLine("Validation errors found:");
                console.WriteLine();
                foreach (var (setting, errors) in allErrors) {
                    console.WriteLine($"  {setting.SourceFilePath}:");
                    foreach (var error in errors) {
                        console.WriteError($"    - {error}");
                    }
                    console.WriteLine();
                }
                throw new ValidationException($"Settings.yaml validation failed with {allErrors.Sum(e => e.Errors.Count)} error(s) in {allErrors.Count} of {settings.Count} file(s).");
            }

            console.WriteLine(" done");
            console.WriteSuccess($"{settings.Count:N0} Settings.yaml files loaded and validated successfully!");

            var metaData = metadataBuilder.Build(settings, headerTableSettings);
            return metaData;
        }
    }
}
