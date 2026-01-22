// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.ComponentModel.DataAnnotations;
using Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject;
using Finstar.DatabaseMigrationGenerator.Infrastructure;

namespace Finstar.DatabaseMigrationGenerator.Application.Changeset
{
    public class ChangesetGenerationService(IChangesetReader changesetReader) : IChangesetGenerationService
    {
        public async Task<IEnumerable<IChangesets>> ValidateAsync(string migrationsPath)
        {
            Console.Write("Reading changeset files...");
            var changesetsEnumerable = await changesetReader.ReadAsync(migrationsPath, (current, total) =>
            {
                Console.Write($"\rReading changeset files... {current}/{total}");
            });
            var changesets = changesetsEnumerable.ToList();
            Console.WriteLine(" done");

            Console.Write("Validating changesets...");
            var allErrors = new List<(IChangesets Changeset, List<string> Errors)>();
            foreach (var changeset in changesets) {
                var errors = changeset.Validate();
                if (errors.Count > 0) {
                    allErrors.Add((changeset, errors));
                }
            }

            if (allErrors.Count > 0) {
                Console.WriteLine("Changeset validation errors found:");
                Console.WriteLine();
                foreach (var (changeset, errors) in allErrors) {
                    Console.WriteLine($"  {changeset.SourceFilePath}:");
                    foreach (var error in errors) {
                        Console.ForegroundColor = ConsoleColor.DarkRed;
                        Console.WriteLine($"    - {error}");
                        Console.ResetColor();
                    }
                    Console.WriteLine();
                }
                throw new ValidationException($"SchemaChangeLog.sql validation failed with {allErrors.Sum(e => e.Errors.Count)} error(s) in {allErrors.Count} of {changesets.Count} file(s).");
            }

            Console.WriteLine(" done");
            Console.ForegroundColor = ConsoleColor.DarkGreen;
            Console.WriteLine($"{changesets.Count:N0} SchemaChangeLog.sql files loaded and validated successfully!");
            Console.ResetColor();

            return changesets;
        }
    }
}
