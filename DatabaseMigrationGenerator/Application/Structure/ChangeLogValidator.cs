// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Application.Structure
{
    public class ChangeLogValidator(List<string> errors)
    {
        private static readonly IDeserializer Deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .IgnoreUnmatchedProperties()
            .Build();

        private static readonly HashSet<string> AllowedMissingFiles = new(StringComparer.OrdinalIgnoreCase)
        {
            "ECH0196SecurityTypeMapping/SchemaChangeLog.sql"
        };

        public void ValidateSchemaChangeLog(string folderPath, string folderName)
        {
            var changeLogPath = Path.Combine(folderPath, "SchemaChangeLog.yaml");
            if (!File.Exists(changeLogPath)) return;

            var location = $"Migrations/{folderName}/SchemaChangeLog.yaml";
            var changeLog = ParseYaml<SchemaChangeLogRoot>(changeLogPath, location);
            if (changeLog?.DatabaseChangeLog == null) return;

            var referencedFiles = CollectAndValidateIncludes(changeLog.DatabaseChangeLog, folderPath, location);
            ValidateAllSqlFilesReferenced(folderPath, referencedFiles, location);
        }

        public void ValidateReleasesChangeLog(string releasesPath)
        {
            var changeLogPath = Path.Combine(releasesPath, "ChangeLog.yaml");
            if (!File.Exists(changeLogPath)) return;

            const string location = "Migrations/Tables/Releases/ChangeLog.yaml";
            var changeLog = ParseYaml<ReleasesChangeLogRoot>(changeLogPath, location);
            if (changeLog?.DatabaseChangeLog == null) return;

            var referencedPaths = CollectAndValidateIncludeAlls(changeLog.DatabaseChangeLog, releasesPath, location);
            ValidateAllFoldersReferenced(releasesPath, referencedPaths, location);
        }

        private T? ParseYaml<T>(string filePath, string location) where T : class
        {
            try
            {
                var content = File.ReadAllText(filePath);
                var root = Deserializer.Deserialize<T>(content);

                if (!HasDatabaseChangeLog(root))
                {
                    AddError(location, "Must have root 'databaseChangeLog:'.");
                    return null;
                }

                return root;
            }
            catch (Exception ex)
            {
                AddError(location, $"Failed to parse YAML: {ex.Message}");
                return null;
            }
        }

        private static bool HasDatabaseChangeLog<T>(T? root) => root switch
        {
            SchemaChangeLogRoot s => s.DatabaseChangeLog != null,
            ReleasesChangeLogRoot r => r.DatabaseChangeLog != null,
            _ => false
        };

        private HashSet<string> CollectAndValidateIncludes(
            List<SchemaChangeLogEntry> entries,
            string folderPath,
            string location)
        {
            var referencedFiles = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            foreach (var entry in entries.Where(e => e.Include != null))
            {
                ValidateIncludeEntry(entry.Include!, folderPath, location, referencedFiles);
            }

            return referencedFiles;
        }

        private void ValidateIncludeEntry(
            IncludeEntry include,
            string folderPath,
            string location,
            HashSet<string> referencedFiles)
        {
            if (string.IsNullOrEmpty(include.File))
            {
                AddError(location, "Include entry missing 'file:' attribute.");
                return;
            }

            ValidateRelativeToChangelogFile(include.RelativeToChangelogFile, include.File, location);
            ValidateFileExists(folderPath, include.File, location);

            referencedFiles.Add(NormalizePath(include.File));
        }

        private HashSet<string> CollectAndValidateIncludeAlls(
            List<ReleasesChangeLogEntry> entries,
            string releasesPath,
            string location)
        {
            var referencedPaths = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            foreach (var entry in entries.Where(e => e.IncludeAll != null))
            {
                ValidateIncludeAllEntry(entry.IncludeAll!, releasesPath, location, referencedPaths);
            }

            return referencedPaths;
        }

        private void ValidateIncludeAllEntry(
            IncludeAllEntry includeAll,
            string releasesPath,
            string location,
            HashSet<string> referencedPaths)
        {
            if (string.IsNullOrEmpty(includeAll.Path))
            {
                AddError(location, "IncludeAll entry missing 'path:' attribute.");
                return;
            }

            ValidateRelativeToChangelogFile(includeAll.RelativeToChangelogFile, includeAll.Path, location);
            ValidateEndsWithFilter(includeAll.EndsWithFilter, includeAll.Path, location);
            ValidateDirectoryExists(releasesPath, includeAll.Path, location);

            referencedPaths.Add(NormalizePath(includeAll.Path));
        }

        private void ValidateRelativeToChangelogFile(bool isRelative, string pathOrFile, string location)
        {
            if (!isRelative)
            {
                AddError(location, $"Entry for '{pathOrFile}' must have 'relativeToChangelogFile: true'.");
            }
        }

        private void ValidateEndsWithFilter(string? filter, string path, string location)
        {
            if (filter != ".sql")
            {
                AddError(location, $"IncludeAll entry for '{path}' must have 'endsWithFilter: \".sql\"'.");
            }
        }

        private void ValidateFileExists(string basePath, string relativePath, string location)
        {
            var fullPath = ToFullPath(basePath, relativePath);
            if (!File.Exists(fullPath))
            {
                AddError(location, $"Referenced file '{relativePath}' does not exist.");
            }
        }

        private void ValidateDirectoryExists(string basePath, string relativePath, string location)
        {
            var fullPath = ToFullPath(basePath, relativePath);
            if (!Directory.Exists(fullPath))
            {
                AddError(location, $"Referenced path '{relativePath}' does not exist.");
            }
        }

        private void ValidateAllSqlFilesReferenced(string folderPath, HashSet<string> referencedFiles, string location)
        {
            var sqlFiles = Directory.GetFiles(folderPath, "SchemaChangeLog.sql", SearchOption.AllDirectories);

            foreach (var sqlFile in sqlFiles)
            {
                var relativePath = GetRelativePath(folderPath, sqlFile);
                var normalizedPath = NormalizePath(relativePath);

                if (referencedFiles.Contains(normalizedPath)) continue;
                if (AllowedMissingFiles.Contains(normalizedPath)) continue;

                AddError(location, $"SQL file '{relativePath}' is not referenced in SchemaChangeLog.yaml.");
            }
        }

        private void ValidateAllFoldersReferenced(string releasesPath, HashSet<string> referencedPaths, string location)
        {
            foreach (var folder in Directory.GetDirectories(releasesPath))
            {
                var folderName = Path.GetFileName(folder);
                if (folderName == null) continue;

                if (!IsFolderReferenced(folderName, referencedPaths))
                {
                    AddError(location, $"Folder '{folderName}' is not referenced in ChangeLog.yaml.");
                }
            }
        }

        private static bool IsFolderReferenced(string folderName, HashSet<string> referencedPaths) =>
            referencedPaths.Any(p =>
                p.Equals(folderName, StringComparison.OrdinalIgnoreCase) ||
                p.StartsWith(folderName + "/", StringComparison.OrdinalIgnoreCase));

        private void AddError(string location, string message) =>
            errors.Add($"{location}: {message}");

        private static string ToFullPath(string basePath, string relativePath) =>
            Path.Combine(basePath, relativePath.Replace('/', Path.DirectorySeparatorChar));

        private static string GetRelativePath(string basePath, string fullPath) =>
            fullPath.Replace(basePath, "").TrimStart(Path.DirectorySeparatorChar).Replace(Path.DirectorySeparatorChar, '/');

        private static string NormalizePath(string path) =>
            path.Replace('\\', '/').TrimStart('/');

        #region YAML Models

        private class SchemaChangeLogRoot
        {
            public List<SchemaChangeLogEntry>? DatabaseChangeLog { get; set; }
        }

        private class SchemaChangeLogEntry
        {
            public IncludeEntry? Include { get; set; }
        }

        private class IncludeEntry
        {
            public string? File { get; set; }
            public bool RelativeToChangelogFile { get; set; }
        }

        private class ReleasesChangeLogRoot
        {
            public List<ReleasesChangeLogEntry>? DatabaseChangeLog { get; set; }
        }

        private class ReleasesChangeLogEntry
        {
            public IncludeAllEntry? IncludeAll { get; set; }
        }

        private class IncludeAllEntry
        {
            public string? Path { get; set; }
            public bool RelativeToChangelogFile { get; set; }
            public string? EndsWithFilter { get; set; }
        }

        #endregion
    }
}
