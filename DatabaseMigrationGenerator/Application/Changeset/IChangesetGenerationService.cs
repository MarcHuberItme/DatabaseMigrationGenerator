// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject;

namespace Finstar.DatabaseMigrationGenerator.Application.Changeset
{
    public interface IChangesetGenerationService
    {
        Task<IEnumerable<IChangesetSettings>> GenerateAsync(string migrationsPath);
    }
}
