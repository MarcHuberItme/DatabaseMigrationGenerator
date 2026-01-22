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
        public async Task<IEnumerable<IChangesetSettings>> GenerateAsync(string migrationsPath)
        {
            Console.Write("Reading changeset files...");
            var (settingsEnumerable, totalScanned) = await changesetReader.ReadAsync(migrationsPath, (current, total) =>
            {
                Console.Write($"\rReading changeset files... {current}/{total}");
            });
            var settings = settingsEnumerable.ToList();
            Console.WriteLine(" done");

            Console.Write("Validating changesets...");
            var allErrors = new List<(IChangesetSettings Setting, List<string> Errors)>();
            foreach (var setting in settings) {
                var errors = setting.Validate();
                if (errors.Count > 0) {
                    allErrors.Add((setting, errors));
                }
            }

            if (allErrors.Count > 0) {
                Console.WriteLine("Changeset validation errors found:");
                Console.WriteLine();
                foreach (var (setting, errors) in allErrors) {
                    Console.WriteLine($"  {setting.SourceFilePath}:");
                    foreach (var error in errors) {
                        Console.ForegroundColor = ConsoleColor.DarkRed;
                        Console.WriteLine($"    - {error}");
                        Console.ResetColor();
                    }
                    Console.WriteLine();
                }
                throw new ValidationException($"Changeset validation failed with {allErrors.Sum(e => e.Errors.Count)} error(s) in {allErrors.Count} of {settings.Count} file(s).");
            }

            Console.WriteLine(" done");
            Console.ForegroundColor = ConsoleColor.DarkGreen;
            Console.WriteLine($"{settings.Count:N0} SchemaChangeLog.sql files loaded and validated successfully!");
            Console.ResetColor();

            return settings;
        }
    }
}
