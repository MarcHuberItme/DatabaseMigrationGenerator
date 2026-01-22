// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.Text.RegularExpressions;

namespace Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject
{
    public static partial class ChangesetValidators
    {
        private const string ExpectedChangesetRoot = "--liquibase formatted sql";

        // Placeholder regex - to be refined by user
        [GeneratedRegex(@"^--changeset\s+.+$", RegexOptions.Compiled)]
        private static partial Regex ChangesetHeaderPattern();

        [GeneratedRegex(@"^--comment:\s*.+$", RegexOptions.Compiled)]
        private static partial Regex CommentPattern();

        // Pattern for release files: YYYYMMDD-HHMM-AnyCharacters.sql
        [GeneratedRegex(@"^\d{8}-\d{4}-.+\.sql$", RegexOptions.Compiled)]
        private static partial Regex ReleaseFileNamePattern();

        public static void ValidateChangesetRoot(List<string> errors, string? changesetRoot)
        {
            if (string.IsNullOrEmpty(changesetRoot)) {
                errors.Add($"ChangesetRoot is required. First line must be '{ExpectedChangesetRoot}'.");
                return;
            }
            if (changesetRoot.Trim() != ExpectedChangesetRoot) {
                errors.Add($"ChangesetRoot must be '{ExpectedChangesetRoot}'. Found: '{changesetRoot.Trim()}'.");
            }
        }

        public static void ValidateChangesetHeader(List<string> errors, string? header, int index)
        {
            if (string.IsNullOrEmpty(header)) {
                errors.Add($"Changeset[{index}] Header is required.");
                return;
            }
            if (!ChangesetHeaderPattern().IsMatch(header.Trim())) {
                errors.Add($"Changeset[{index}] Header must match pattern '--changeset ...'. Found: '{header.Trim()}'.");
            }
        }

        public static void ValidateComment(List<string> errors, string? comment, int index)
        {
            if (string.IsNullOrEmpty(comment)) {
                errors.Add($"Changeset[{index}] Comment is required.");
                return;
            }
            if (!CommentPattern().IsMatch(comment.Trim())) {
                errors.Add($"Changeset[{index}] Comment must match pattern '--comment: ...'. Found: '{comment.Trim()}'.");
            }
        }

        public static void ValidateSql(List<string> errors, string? sql, int index)
        {
            if (string.IsNullOrWhiteSpace(sql)) {
                errors.Add($"Changeset[{index}] Sql is required.");
            }
        }

        public static void ValidateViewSql(List<string> errors, string? sql, int index)
        {
            ValidateSql(errors, sql, index);
            if (!string.IsNullOrWhiteSpace(sql)) {
                var firstLine = sql.Trim().Split('\n')[0].Trim();
                if (!firstLine.StartsWith("CREATE OR ALTER VIEW", StringComparison.OrdinalIgnoreCase)) {
                    errors.Add($"Changeset[{index}] Sql must start with 'CREATE OR ALTER VIEW'. Found: '{firstLine}'.");
                }
            }
        }

        public static void ValidateFunctionSql(List<string> errors, string? sql, int index)
        {
            ValidateSql(errors, sql, index);
            if (!string.IsNullOrWhiteSpace(sql)) {
                var firstLine = sql.Trim().Split('\n')[0].Trim();
                if (!firstLine.StartsWith("CREATE OR ALTER FUNCTION", StringComparison.OrdinalIgnoreCase)) {
                    errors.Add($"Changeset[{index}] Sql must start with 'CREATE OR ALTER FUNCTION'. Found: '{firstLine}'.");
                }
            }
        }

        public static void ValidateStoredProcedureSql(List<string> errors, string? sql, int index)
        {
            ValidateSql(errors, sql, index);
            if (!string.IsNullOrWhiteSpace(sql)) {
                var firstLine = sql.Trim().Split('\n')[0].Trim();
                if (!firstLine.StartsWith("CREATE OR ALTER PROCEDURE", StringComparison.OrdinalIgnoreCase)) {
                    errors.Add($"Changeset[{index}] Sql must start with 'CREATE OR ALTER PROCEDURE'. Found: '{firstLine}'.");
                }
            }
        }

        public static void ValidateReleaseFileName(List<string> errors, string filePath)
        {
            var fileName = Path.GetFileName(filePath);
            if (!ReleaseFileNamePattern().IsMatch(fileName)) {
                errors.Add($"Release file name must match pattern 'YYYYMMDD-HHMM-Name.sql'. Found: '{fileName}'.");
            }
        }

        public static bool IsReleaseFile(string filePath)
        {
            return filePath.Contains(Path.Combine("Tables", "Releases"), StringComparison.OrdinalIgnoreCase);
        }
    }
}
