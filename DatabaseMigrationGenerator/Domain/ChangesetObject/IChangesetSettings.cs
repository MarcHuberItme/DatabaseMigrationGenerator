// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject
{
    public interface IChangesetSettings
    {
        string SourceFilePath { get; set; }
        ChangesetType Type { get; }
        string ChangesetRoot { get; init; }
        List<ChangesetEntry> Changesets { get; init; }
        List<string> Validate();
    }
}
