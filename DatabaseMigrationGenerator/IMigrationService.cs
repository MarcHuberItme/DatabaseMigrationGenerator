// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator
{
    public interface IMigrationService
    {
        Task CreateChangeSetsAsync();
    }
}