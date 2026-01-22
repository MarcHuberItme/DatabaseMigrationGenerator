// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class ChangesetReader : IChangesetReader
    {
        private const string ChangesetMarker = "--changeset";
        private const string CommentMarker = "--comment:";

        public async Task<IEnumerable<IChangesets>> ReadAsync(
            string migrationsPath,
            Action<int, int>? progressCallback = null)
        {
            var sqlFiles = GetSqlFiles(migrationsPath);
            var totalFiles = sqlFiles.Count;
            var changesets = new List<IChangesets>();

            for (int i = 0; i < totalFiles; i++) {
                var filePath = sqlFiles[i];
                var changesetContent = await ParseFileAsync(filePath, migrationsPath);
                if (changesetContent != null) {
                    changesets.Add(changesetContent);
                }

                if ((i + 1) % 100 == 0 || i == totalFiles - 1) {
                    progressCallback?.Invoke(i + 1, totalFiles);
                }
            }

            return changesets;
        }

        private static List<string> GetSqlFiles(string migrationsPath)
        {
            var files = new List<string>();

            var tablePath = Path.Combine(migrationsPath, "Tables");
            var viewPath = Path.Combine(migrationsPath, "Views");
            var functionPath = Path.Combine(migrationsPath, "Functions");
            var storedProcedurePath = Path.Combine(migrationsPath, "StoredProcedures");

            if (Directory.Exists(tablePath)) {
                files.AddRange(Directory.GetFiles(tablePath, "*.sql", SearchOption.AllDirectories)
                    .Where(f => !f.EndsWith(".yaml", StringComparison.OrdinalIgnoreCase)));
            }
            if (Directory.Exists(viewPath)) {
                files.AddRange(Directory.GetFiles(viewPath, "*.sql", SearchOption.AllDirectories));
            }
            if (Directory.Exists(functionPath)) {
                files.AddRange(Directory.GetFiles(functionPath, "*.sql", SearchOption.AllDirectories));
            }
            if (Directory.Exists(storedProcedurePath)) {
                files.AddRange(Directory.GetFiles(storedProcedurePath, "*.sql", SearchOption.AllDirectories));
            }

            return files;
        }

        private static async Task<IChangesets?> ParseFileAsync(string filePath, string migrationsPath)
        {
            var content = await File.ReadAllTextAsync(filePath);
            var lines = content.Split('\n');

            if (lines.Length == 0) {
                return null;
            }

            var changesetRoot = lines[0].TrimEnd('\r');
            var changesetsContent = ParseChangesets(lines);
            var type = DetermineChangesetType(filePath, migrationsPath);
            var isReleaseFile = ChangesetValidators.IsReleaseFile(filePath);

            IChangesets changesets = type switch {
                ChangesetType.Table => new TableChangesets {
                    ChangesetRoot = changesetRoot,
                    Changesets = changesetsContent,
                    IsReleaseFile = isReleaseFile
                },
                ChangesetType.View => new ViewChangesets {
                    ChangesetRoot = changesetRoot,
                    Changesets = changesetsContent
                },
                ChangesetType.Function => new FunctionChangesets {
                    ChangesetRoot = changesetRoot,
                    Changesets = changesetsContent
                },
                ChangesetType.StoredProcedure => new StoredProcedureChangesets {
                    ChangesetRoot = changesetRoot,
                    Changesets = changesetsContent
                },
                _ => throw new InvalidOperationException($"Unknown changeset type for file: {filePath}")
            };

            changesets.SourceFilePath = filePath;
            return changesets;
        }

        private static List<ChangesetEntry> ParseChangesets(string[] lines)
        {
            var changesets = new List<ChangesetEntry>();
            var currentHeader = string.Empty;
            var currentComment = string.Empty;
            var sqlLines = new List<string>();
            var inChangeset = false;

            for (int i = 1; i < lines.Length; i++) {
                var line = lines[i].TrimEnd('\r');

                if (line.TrimStart().StartsWith(ChangesetMarker, StringComparison.OrdinalIgnoreCase)) {
                    // Save previous changeset if exists
                    if (inChangeset) {
                        changesets.Add(new ChangesetEntry {
                            Header = currentHeader,
                            Comment = currentComment,
                            Sql = string.Join("\n", sqlLines).Trim()
                        });
                    }

                    // Start new changeset
                    currentHeader = line;
                    currentComment = string.Empty;
                    sqlLines.Clear();
                    inChangeset = true;
                } else if (inChangeset && line.TrimStart().StartsWith(CommentMarker, StringComparison.OrdinalIgnoreCase) && string.IsNullOrEmpty(currentComment)) {
                    currentComment = line;
                } else if (inChangeset) {
                    sqlLines.Add(line);
                }
            }

            // Save last changeset
            if (inChangeset) {
                changesets.Add(new ChangesetEntry {
                    Header = currentHeader,
                    Comment = currentComment,
                    Sql = string.Join("\n", sqlLines).Trim()
                });
            }

            return changesets;
        }

        private static ChangesetType DetermineChangesetType(string filePath, string migrationsPath)
        {
            var relativePath = filePath.Replace(migrationsPath, "").TrimStart(Path.DirectorySeparatorChar);
            var firstFolder = relativePath.Split(Path.DirectorySeparatorChar)[0];

            return firstFolder.ToLowerInvariant() switch {
                "tables" => ChangesetType.Table,
                "views" => ChangesetType.View,
                "functions" => ChangesetType.Function,
                "storedprocedures" => ChangesetType.StoredProcedure,
                _ => throw new InvalidOperationException($"Unknown folder type: {firstFolder}")
            };
        }
    }
}
