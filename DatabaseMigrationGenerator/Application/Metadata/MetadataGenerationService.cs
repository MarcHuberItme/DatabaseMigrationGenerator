// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.Metadata;
using Finstar.DatabaseMigrationGenerator.Infrastructure;

namespace Finstar.DatabaseMigrationGenerator.Application.Metadata
{
    public class MetadataGenerationService(
        ISettingsReader settingsReader,
        IHeaderTableSettingsReader headerTableSettingsReader,
        IMetadataBuilder metadataBuilder) : IMetadataGenerationService
    {
        public async Task<IEnumerable<IMetadata>> Generate(string migrationsPath)
        {
            var settings = (await settingsReader.ReadAsync(migrationsPath)).ToList();
            settings.ForEach(setting => setting.Validate());
        
            var headerTableSettings = await headerTableSettingsReader.ReadAsync(migrationsPath);
            var metaData = metadataBuilder.Build(settings, headerTableSettings);
            return metaData;
        }
    }
}