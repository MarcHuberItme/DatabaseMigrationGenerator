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
        private const int ProgressReportInterval = 100;

        private static readonly string[] SqlFolders = ["Tables", "Views", "Functions", "StoredProcedures"];

        public async Task<IEnumerable<IChangesets>> ReadAsync(
            string migrationsPath,
            Action<int, int>? progressCallback = null)
        {
            var sqlFiles = GetSqlFiles(migrationsPath);
            var changesets = new List<IChangesets>();

            for (int i = 0; i < sqlFiles.Count; i++)
            {
                var changesetContent = await ParseFileAsync(sqlFiles[i], migrationsPath);
                if (changesetContent != null)
                {
                    changesets.Add(changesetContent);
                }

                ReportProgress(i + 1, sqlFiles.Count, progressCallback);
            }

            return changesets;
        }

        private static void ReportProgress(int current, int total, Action<int, int>? callback)
        {
            if (callback == null) return;
            if (current % ProgressReportInterval == 0 || current == total)
            {
                callback(current, total);
            }
        }

        private static List<string> GetSqlFiles(string migrationsPath)
        {
            var files = new List<string>();

            foreach (var folder in SqlFolders)
            {
                var path = Path.Combine(migrationsPath, folder);
                if (!Directory.Exists(path)) continue;

                var sqlFiles = Directory.GetFiles(path, "*.sql", SearchOption.AllDirectories);
                files.AddRange(sqlFiles);
            }

            return files;
        }

        private static async Task<IChangesets?> ParseFileAsync(string filePath, string migrationsPath)
        {
            var content = await File.ReadAllTextAsync(filePath);
            var lines = content.Split('\n');

            if (lines.Length == 0) return null;

            var changesetRoot = lines[0].TrimEnd('\r');
            var changesetsContent = ParseChangesets(lines);
            var type = DetermineChangesetType(filePath, migrationsPath);

            var changesets = CreateChangesets(type, changesetRoot, changesetsContent, filePath);
            changesets.SourceFilePath = filePath;
            return changesets;
        }

        private static IChangesets CreateChangesets(
            ChangesetType type,
            string changesetRoot,
            List<ChangesetEntry> entries,
            string filePath)
        {
            return type switch
            {
                ChangesetType.Table => new TableChangesets
                {
                    ChangesetRoot = changesetRoot,
                    Changesets = entries,
                    IsReleaseFile = ChangesetValidators.IsReleaseFile(filePath)
                },
                ChangesetType.View => new ViewChangesets
                {
                    ChangesetRoot = changesetRoot,
                    Changesets = entries
                },
                ChangesetType.Function => new FunctionChangesets
                {
                    ChangesetRoot = changesetRoot,
                    Changesets = entries
                },
                ChangesetType.StoredProcedure => new StoredProcedureChangesets
                {
                    ChangesetRoot = changesetRoot,
                    Changesets = entries
                },
                _ => throw new InvalidOperationException($"Unknown changeset type for file: {filePath}")
            };
        }

        private static List<ChangesetEntry> ParseChangesets(string[] lines)
        {
            var changesets = new List<ChangesetEntry>();
            var builder = new ChangesetEntryBuilder();

            for (int i = 1; i < lines.Length; i++)
            {
                var line = lines[i].TrimEnd('\r');
                ProcessLine(line, builder, changesets);
            }

            builder.SaveCurrentChangeset(changesets);
            return changesets;
        }

        private static void ProcessLine(string line, ChangesetEntryBuilder builder, List<ChangesetEntry> changesets)
        {
            if (IsChangesetHeader(line))
            {
                builder.SaveCurrentChangeset(changesets);
                builder.StartNewChangeset(line);
            }
            else if (builder.IsInChangeset && IsComment(line) && !builder.HasComment)
            {
                builder.SetComment(line);
            }
            else if (builder.IsInChangeset)
            {
                builder.AddSqlLine(line);
            }
        }

        private static bool IsChangesetHeader(string line) =>
            line.TrimStart().StartsWith(ChangesetMarker, StringComparison.OrdinalIgnoreCase);

        private static bool IsComment(string line) =>
            line.TrimStart().StartsWith(CommentMarker, StringComparison.OrdinalIgnoreCase);

        private static ChangesetType DetermineChangesetType(string filePath, string migrationsPath)
        {
            var relativePath = filePath.Replace(migrationsPath, "").TrimStart(Path.DirectorySeparatorChar);
            var firstFolder = relativePath.Split(Path.DirectorySeparatorChar)[0];

            return firstFolder.ToLowerInvariant() switch
            {
                "tables" => ChangesetType.Table,
                "views" => ChangesetType.View,
                "functions" => ChangesetType.Function,
                "storedprocedures" => ChangesetType.StoredProcedure,
                _ => throw new InvalidOperationException($"Unknown folder type: {firstFolder}")
            };
        }

        private class ChangesetEntryBuilder
        {
            private string _header = string.Empty;
            private string _comment = string.Empty;
            private readonly List<string> _sqlLines = [];

            public bool IsInChangeset { get; private set; }
            public bool HasComment => !string.IsNullOrEmpty(_comment);

            public void StartNewChangeset(string header)
            {
                _header = header;
                _comment = string.Empty;
                _sqlLines.Clear();
                IsInChangeset = true;
            }

            public void SetComment(string comment) => _comment = comment;

            public void AddSqlLine(string line) => _sqlLines.Add(line);

            public void SaveCurrentChangeset(List<ChangesetEntry> changesets)
            {
                if (!IsInChangeset) return;

                changesets.Add(new ChangesetEntry
                {
                    Header = _header,
                    Comment = _comment,
                    Sql = string.Join("\n", _sqlLines).Trim()
                });
            }
        }
    }
}
