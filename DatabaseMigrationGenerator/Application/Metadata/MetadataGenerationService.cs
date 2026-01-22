// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.ComponentModel.DataAnnotations;
using Finstar.DatabaseMigrationGenerator.Domain.Metadata;
using Finstar.DatabaseMigrationGenerator.Domain.SettingsObject;
using Finstar.DatabaseMigrationGenerator.Infrastructure;

namespace Finstar.DatabaseMigrationGenerator.Application.Metadata
{
    public class MetadataGenerationService(
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
            Console.WriteLine(" done");

            var (settingsEnumerable, totalScanned) = await settingsReader.ReadAsync(migrationsPath, (current, total) =>
            {
                Console.Write($"\rReading settings files... {current}/{total}");
            });
            var settings = settingsEnumerable.ToList();
            Console.WriteLine(" done");

            Console.Write("Validating settings...");
            var allErrors = new List<(ISettings Setting, List<string> Errors)>();
            foreach (var setting in settings) {
                var errors = setting.Validate();
                if (errors.Count > 0) {
                    allErrors.Add((setting, errors));
                }
            }

            if (allErrors.Count > 0) {
                Console.WriteLine();
                Console.WriteLine("Validation errors found:");
                Console.WriteLine();
                foreach (var (setting, errors) in allErrors) {
                    Console.WriteLine($"  {setting.SourceFilePath}:");
                    foreach (var error in errors) {
                        Console.ForegroundColor = ConsoleColor.DarkRed;
                        Console.WriteLine($"    - {error}");
                        Console.ResetColor();
                    }
                    Console.WriteLine();
                }
                throw new ValidationException($"Validation failed with {allErrors.Sum(e => e.Errors.Count)} error(s) in {allErrors.Count} of {settings.Count} file(s).");
            }

            Console.WriteLine(" done");
            Console.ForegroundColor = ConsoleColor.DarkGreen;
            Console.WriteLine($"{settings.Count:N0} Settings.yaml files loaded and validated successfully!");
            Console.ResetColor();

            var metaData = metadataBuilder.Build(settings, headerTableSettings);
            return metaData;
        }
    }
}
