// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.ComponentModel.DataAnnotations;
using Finstar.DatabaseMigrationGenerator.Application.Output;
using Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject;
using Finstar.DatabaseMigrationGenerator.Infrastructure;

namespace Finstar.DatabaseMigrationGenerator.Application.Changeset
{
    public class ChangesetGenerationService(
        IConsoleOutput console,
        IChangesetReader changesetReader) : IChangesetGenerationService
    {
        public async Task<IEnumerable<IChangesets>> ValidateAsync(string migrationsPath)
        {
            var changesetsEnumerable = await changesetReader.ReadAsync(migrationsPath, (current, total) =>
            {
                console.WriteProgress($"Reading changeset files... {current}/{total}");
            });
            var changesets = changesetsEnumerable.ToList();
            console.WriteLine(" done");

            console.Write("Validating changesets...");
            var allErrors = new List<(IChangesets Changeset, List<string> Errors)>();
            foreach (var changeset in changesets) {
                var errors = changeset.Validate();
                if (errors.Count > 0) {
                    allErrors.Add((changeset, errors));
                }
            }

            if (allErrors.Count > 0) {
                console.WriteLine();
                console.WriteLine("Changeset validation errors found:");
                console.WriteLine();
                foreach (var (changeset, errors) in allErrors) {
                    console.WriteLine($"  {changeset.SourceFilePath}:");
                    foreach (var error in errors) {
                        console.WriteError($"    - {error}");
                    }
                    console.WriteLine();
                }
                throw new ValidationException($"SchemaChangeLog.sql validation failed with {allErrors.Sum(e => e.Errors.Count)} error(s) in {allErrors.Count} of {changesets.Count} file(s).");
            }

            console.WriteLine(" done");
            console.WriteSuccess($"{changesets.Count:N0} SchemaChangeLog.sql files loaded and validated successfully!");

            return changesets;
        }
    }
}
