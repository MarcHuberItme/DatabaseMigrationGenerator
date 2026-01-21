// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.ComponentModel.DataAnnotations;
using Finstar.DatabaseMigrationGenerator.Domain.Metadata;
using Finstar.DatabaseMigrationGenerator.Domain.SettingsObject;
using Finstar.DatabaseMigrationGenerator.Infrastructure;
using Microsoft.Extensions.Logging;

namespace Finstar.DatabaseMigrationGenerator.Application.Metadata
{
    public class MetadataGenerationService(
        ILogger<MetadataGenerationService> logger,
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
            Console.Write("Loading configuration...");
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
            Console.WriteLine(" done.");

            Console.Write("Reading settings files... ");
            var progress = new Progress<(int current, int total)>(p =>
            {
                Console.Write($"\rReading settings files... {p.current}/{p.total}");
            });
            var (settingsEnumerable, totalScanned) = await settingsReader.ReadAsync(migrationsPath, progress);
            var settings = settingsEnumerable.ToList();
            Console.WriteLine($"\rReading settings files... {settings.Count} table(s) of {totalScanned} file(s) found.");

            Console.Write("Validating settings...");
            var allErrors = new List<(ISettings Setting, List<string> Errors)>();
            foreach (var setting in settings) {
                var errors = setting.Validate();
                if (errors.Count > 0) {
                    allErrors.Add((setting, errors));
                }
            }
            Console.WriteLine(" done.");

            if (allErrors.Count > 0) {
                logger.LogWarning("Validation errors found:");
                logger.LogWarning("");
                foreach (var (setting, errors) in allErrors) {
                    logger.LogWarning("  {SourceFilePath}:", setting.SourceFilePath);
                    foreach (var error in errors) {
                        logger.LogError("    - {Error}", error);
                    }
                    logger.LogWarning("");
                }
                throw new ValidationException($"Validation failed with {allErrors.Sum(e => e.Errors.Count)} error(s) in {allErrors.Count} of {settings.Count} file(s).");
            }

            logger.LogInformation("Validation successful: {Count} file(s) validated.", settings.Count);

            var metaData = metadataBuilder.Build(settings, headerTableSettings);
            return metaData;
        }
    }
}