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
        IMetadataBuilder metadataBuilder) : IMetadataGenerationService
    {
        public async Task<IEnumerable<IMetadata>> Generate(string migrationsPath)
        {
            var validDomainTypes = await mdDomainTypeReader.ReadAsync(migrationsPath);
            TableSettings.SetValidDomainTypes(validDomainTypes);

            var settings = (await settingsReader.ReadAsync(migrationsPath)).ToList();

            var allErrors = new List<(ISettings Setting, List<string> Errors)>();
            foreach (var setting in settings) {
                var errors = setting.Validate();
                if (errors.Count > 0) {
                    allErrors.Add((setting, errors));
                }
            }

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
                throw new ValidationException($"Validation failed with {allErrors.Sum(e => e.Errors.Count)} error(s) in {allErrors.Count} file(s).");
            }

            logger.LogInformation("Validation successful: {Count} file(s) validated.", settings.Count);

            var headerTableSettings = await headerTableSettingsReader.ReadAsync(migrationsPath);
            var metaData = metadataBuilder.Build(settings, headerTableSettings);
            return metaData;
        }
    }
}