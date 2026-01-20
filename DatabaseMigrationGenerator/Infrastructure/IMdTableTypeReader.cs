// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public interface IMdTableTypeReader
    {
        Task<byte[]> ReadAsync(string migrationsPath);
    }
}
