// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.Metadata;

namespace Finstar.DatabaseMigrationGenerator.Application.Metadata
{
    public interface IMetadataGenerationService
    {
        Task<IEnumerable<IMetadata>> Generate(string migrationsPath);
    }
}