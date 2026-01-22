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

        //[GeneratedRegex(@"^--changeset\s+.+$", RegexOptions.Compiled)]
        [GeneratedRegex(@"^--changeset (?=.{0,6}:)[a-z]+:(?=.{0,255} context:)[A-Za-z0-9-_]* context:(any|prd|tsn|tst) labels:(?=.{1,255}$)c-[a-z]+,o-(table|view|stored-procedure|function|extended-properties|permission),ot-(schema|data),on-[A-Za-z0-9_]+,fin-[0-9]+", RegexOptions.Compiled)]
        
        private static partial Regex ChangesetHeaderPattern();

        [GeneratedRegex(@"^--comment:\s*.+$", RegexOptions.Compiled)]
        private static partial Regex CommentPattern();

        [GeneratedRegex(@"^\d{8}-\d{4}-.+\.sql$", RegexOptions.Compiled)]
        private static partial Regex ReleaseFileNamePattern();

        public static void ValidateChangesetRoot(List<string> errors, string? changesetRoot)
        {
            if (string.IsNullOrEmpty(changesetRoot))
            {
                errors.Add($"ChangesetRoot is required. First line must be '{ExpectedChangesetRoot}'.");
                return;
            }

            if (changesetRoot.Trim() != ExpectedChangesetRoot)
            {
                errors.Add($"ChangesetRoot must be '{ExpectedChangesetRoot}'. Found: '{changesetRoot.Trim()}'.");
            }
        }

        public static void ValidateChangesetHeader(List<string> errors, string? header, int index)
        {
            if (string.IsNullOrEmpty(header))
            {
                errors.Add($"Changeset[{index}] Header is required.");
                return;
            }

            if (!ChangesetHeaderPattern().IsMatch(header.Trim()))
            {
                errors.Add($"Changeset[{index}] Header must match pattern '--changeset mhy:create-alter-function-AccClosingPeriodInfo context:any labels:c-any1,o-function,ot-schema,on-AccClosingPeriodInfo,fin-13659'. Found: '{header.Trim()}'.");
            }
        }

        public static void ValidateComment(List<string> errors, string? comment, int index)
        {
            if (string.IsNullOrEmpty(comment))
            {
                errors.Add($"Changeset[{index}] Comment is required.");
                return;
            }

            if (!CommentPattern().IsMatch(comment.Trim()))
            {
                errors.Add($"Changeset[{index}] Comment must match pattern '--comment: ...'. Found: '{comment.Trim()}'.");
            }
        }

        public static void ValidateSql(List<string> errors, string? sql, int index)
        {
            if (string.IsNullOrWhiteSpace(sql))
            {
                errors.Add($"Changeset[{index}] Sql is required.");
            }
        }

        public static void ValidateViewSql(List<string> errors, string? sql, int index) =>
            ValidateSqlWithPrefix(errors, sql, index, "CREATE OR ALTER VIEW");

        public static void ValidateFunctionSql(List<string> errors, string? sql, int index) =>
            ValidateSqlWithPrefix(errors, sql, index, "CREATE OR ALTER FUNCTION");

        public static void ValidateStoredProcedureSql(List<string> errors, string? sql, int index) =>
            ValidateSqlWithPrefix(errors, sql, index, "CREATE OR ALTER PROCEDURE");

        private static void ValidateSqlWithPrefix(List<string> errors, string? sql, int index, string expectedPrefix)
        {
            ValidateSql(errors, sql, index);

            if (string.IsNullOrWhiteSpace(sql)) return;

            var firstLine = GetFirstLine(sql);
            if (!firstLine.StartsWith(expectedPrefix, StringComparison.OrdinalIgnoreCase))
            {
                errors.Add($"Changeset[{index}] Sql must start with '{expectedPrefix}'. Found: '{firstLine}'.");
            }
        }

        private static string GetFirstLine(string sql) =>
            sql.Trim().Split('\n')[0].Trim();

        public static void ValidateReleaseFileName(List<string> errors, string filePath)
        {
            var fileName = Path.GetFileName(filePath);
            if (!ReleaseFileNamePattern().IsMatch(fileName))
            {
                errors.Add($"Release file name must match pattern 'YYYYMMDD-HHMM-Name.sql'. Found: '{fileName}'.");
            }
        }

        public static bool IsReleaseFile(string filePath) =>
            filePath.Contains(Path.Combine("Tables", "Releases"), StringComparison.OrdinalIgnoreCase);
    }
}
