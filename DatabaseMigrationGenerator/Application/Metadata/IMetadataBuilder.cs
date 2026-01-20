// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.HeaderTable;
using Finstar.DatabaseMigrationGenerator.Domain.Metadata;
using Finstar.DatabaseMigrationGenerator.Domain.SettingsObject;

namespace Finstar.DatabaseMigrationGenerator.Application.Metadata
{
    public interface IMetadataBuilder
    {
        IEnumerable<IMetadata> Build(IEnumerable<ISettings> settings, IEnumerable<HeaderTableSettings> headerTableSettings);
    }
}