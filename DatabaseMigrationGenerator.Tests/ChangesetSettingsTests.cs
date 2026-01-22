// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.ChangesetObject;
using FluentAssertions;

namespace Finstar.DatabaseMigrationGenerator.Tests
{
    [TestClass]
    public class ChangesetSettingsTests
    {
        private static ChangesetEntry CreateValidChangesetEntry(string sqlPrefix = "SELECT 1")
        {
            return new ChangesetEntry {
                Header = "--changeset user:test-changeset context:any labels:test",
                Comment = "--comment: Test comment",
                Sql = sqlPrefix
            };
        }

        #region ChangesetRoot Validation

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_ChangesetRootIsEmpty_ReturnsError(string type)
        {
            var settings = CreateSettings(type, "", [CreateValidChangesetEntry()]);

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("ChangesetRoot") && e.Contains("required"));
        }

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_ChangesetRootIsInvalid_ReturnsError(string type)
        {
            var settings = CreateSettings(type, "--invalid root", [CreateValidChangesetEntry()]);

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("ChangesetRoot") && e.Contains("--liquibase formatted sql"));
        }

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_ChangesetRootIsValid_ReturnsNoError(string type)
        {
            var settings = CreateSettings(type, "--liquibase formatted sql", [CreateValidChangesetEntry()]);

            var errors = settings.Validate();

            errors.Should().NotContain(e => e.Contains("ChangesetRoot"));
        }

        #endregion

        #region Header Validation

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_HeaderIsEmpty_ReturnsError(string type)
        {
            var entry = new ChangesetEntry {
                Header = "",
                Comment = "--comment: Test",
                Sql = "SELECT 1"
            };
            var settings = CreateSettings(type, "--liquibase formatted sql", [entry]);

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("Header") && e.Contains("required"));
        }

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_HeaderIsInvalid_ReturnsError(string type)
        {
            var entry = new ChangesetEntry {
                Header = "--invalid header",
                Comment = "--comment: Test",
                Sql = "SELECT 1"
            };
            var settings = CreateSettings(type, "--liquibase formatted sql", [entry]);

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("Header") && e.Contains("--changeset"));
        }

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_HeaderIsValid_ReturnsNoError(string type)
        {
            var settings = CreateSettings(type, "--liquibase formatted sql", [CreateValidChangesetEntry()]);

            var errors = settings.Validate();

            errors.Should().NotContain(e => e.Contains("Header"));
        }

        #endregion

        #region Comment Validation

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_CommentIsEmpty_ReturnsError(string type)
        {
            var entry = new ChangesetEntry {
                Header = "--changeset user:test",
                Comment = "",
                Sql = "SELECT 1"
            };
            var settings = CreateSettings(type, "--liquibase formatted sql", [entry]);

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("Comment") && e.Contains("required"));
        }

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_CommentIsInvalid_ReturnsError(string type)
        {
            var entry = new ChangesetEntry {
                Header = "--changeset user:test",
                Comment = "-- invalid comment",
                Sql = "SELECT 1"
            };
            var settings = CreateSettings(type, "--liquibase formatted sql", [entry]);

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("Comment") && e.Contains("--comment:"));
        }

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_CommentIsValid_ReturnsNoError(string type)
        {
            var settings = CreateSettings(type, "--liquibase formatted sql", [CreateValidChangesetEntry()]);

            var errors = settings.Validate();

            errors.Should().NotContain(e => e.Contains("Comment"));
        }

        #endregion

        #region Sql Validation

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_SqlIsEmpty_ReturnsError(string type)
        {
            var entry = new ChangesetEntry {
                Header = "--changeset user:test",
                Comment = "--comment: Test",
                Sql = ""
            };
            var settings = CreateSettings(type, "--liquibase formatted sql", [entry]);

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("Sql") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_ViewSqlDoesNotStartWithCreateOrAlterView_ReturnsError()
        {
            var entry = new ChangesetEntry {
                Header = "--changeset user:test",
                Comment = "--comment: Test",
                Sql = "SELECT * FROM MyTable"
            };
            var settings = new ViewChangesetSettings {
                ChangesetRoot = "--liquibase formatted sql",
                Changesets = [entry]
            };

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("CREATE OR ALTER VIEW"));
        }

        [TestMethod]
        public void Validate_ViewSqlStartsWithCreateOrAlterView_ReturnsNoError()
        {
            var entry = new ChangesetEntry {
                Header = "--changeset user:test",
                Comment = "--comment: Test",
                Sql = "CREATE OR ALTER VIEW dbo.MyView AS SELECT 1"
            };
            var settings = new ViewChangesetSettings {
                ChangesetRoot = "--liquibase formatted sql",
                Changesets = [entry]
            };

            var errors = settings.Validate();

            errors.Should().NotContain(e => e.Contains("CREATE OR ALTER VIEW"));
        }

        [TestMethod]
        public void Validate_FunctionSqlDoesNotStartWithCreateOrAlterFunction_ReturnsError()
        {
            var entry = new ChangesetEntry {
                Header = "--changeset user:test",
                Comment = "--comment: Test",
                Sql = "SELECT * FROM MyTable"
            };
            var settings = new FunctionChangesetSettings {
                ChangesetRoot = "--liquibase formatted sql",
                Changesets = [entry]
            };

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("CREATE OR ALTER FUNCTION"));
        }

        [TestMethod]
        public void Validate_FunctionSqlStartsWithCreateOrAlterFunction_ReturnsNoError()
        {
            var entry = new ChangesetEntry {
                Header = "--changeset user:test",
                Comment = "--comment: Test",
                Sql = "CREATE OR ALTER FUNCTION dbo.MyFunc() RETURNS INT AS BEGIN RETURN 1 END"
            };
            var settings = new FunctionChangesetSettings {
                ChangesetRoot = "--liquibase formatted sql",
                Changesets = [entry]
            };

            var errors = settings.Validate();

            errors.Should().NotContain(e => e.Contains("CREATE OR ALTER FUNCTION"));
        }

        [TestMethod]
        public void Validate_StoredProcedureSqlDoesNotStartWithCreateOrAlterProcedure_ReturnsError()
        {
            var entry = new ChangesetEntry {
                Header = "--changeset user:test",
                Comment = "--comment: Test",
                Sql = "SELECT * FROM MyTable"
            };
            var settings = new StoredProcedureChangesetSettings {
                ChangesetRoot = "--liquibase formatted sql",
                Changesets = [entry]
            };

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("CREATE OR ALTER PROCEDURE"));
        }

        [TestMethod]
        public void Validate_StoredProcedureSqlStartsWithCreateOrAlterProcedure_ReturnsNoError()
        {
            var entry = new ChangesetEntry {
                Header = "--changeset user:test",
                Comment = "--comment: Test",
                Sql = "CREATE OR ALTER PROCEDURE dbo.MyProc AS BEGIN SELECT 1 END"
            };
            var settings = new StoredProcedureChangesetSettings {
                ChangesetRoot = "--liquibase formatted sql",
                Changesets = [entry]
            };

            var errors = settings.Validate();

            errors.Should().NotContain(e => e.Contains("CREATE OR ALTER PROCEDURE"));
        }

        [TestMethod]
        public void Validate_TableSqlCanBeAnything_ReturnsNoError()
        {
            var entry = new ChangesetEntry {
                Header = "--changeset user:test",
                Comment = "--comment: Test",
                Sql = "CREATE TABLE dbo.MyTable (Id INT)"
            };
            var settings = new TableChangesetSettings {
                ChangesetRoot = "--liquibase formatted sql",
                Changesets = [entry]
            };

            var errors = settings.Validate();

            errors.Should().NotContain(e => e.Contains("Sql"));
        }

        #endregion

        #region Release File Name Validation

        [TestMethod]
        public void Validate_ReleaseFileNameIsValid_ReturnsNoError()
        {
            var settings = new TableChangesetSettings {
                SourceFilePath = @"C:\Migrations\Tables\Releases\20251208-1022-AcAmountType.sql",
                ChangesetRoot = "--liquibase formatted sql",
                Changesets = [CreateValidChangesetEntry()],
                IsReleaseFile = true
            };

            var errors = settings.Validate();

            errors.Should().NotContain(e => e.Contains("Release file name"));
        }

        [TestMethod]
        public void Validate_ReleaseFileNameIsInvalid_ReturnsError()
        {
            var settings = new TableChangesetSettings {
                SourceFilePath = @"C:\Migrations\Tables\Releases\InvalidFileName.sql",
                ChangesetRoot = "--liquibase formatted sql",
                Changesets = [CreateValidChangesetEntry()],
                IsReleaseFile = true
            };

            var errors = settings.Validate();

            errors.Should().Contain(e => e.Contains("Release file name") && e.Contains("YYYYMMDD-HHMM"));
        }

        [TestMethod]
        public void Validate_NonReleaseFileWithInvalidName_ReturnsNoError()
        {
            var settings = new TableChangesetSettings {
                SourceFilePath = @"C:\Migrations\Tables\Ac\AcTable\SchemaChangeLog.sql",
                ChangesetRoot = "--liquibase formatted sql",
                Changesets = [CreateValidChangesetEntry()],
                IsReleaseFile = false
            };

            var errors = settings.Validate();

            errors.Should().NotContain(e => e.Contains("Release file name"));
        }

        #endregion

        #region General Validation

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_ValidSettings_ReturnsNoErrors(string type)
        {
            var sqlContent = type switch {
                "View" => "CREATE OR ALTER VIEW dbo.MyView AS SELECT 1",
                "Function" => "CREATE OR ALTER FUNCTION dbo.MyFunc() RETURNS INT AS BEGIN RETURN 1 END",
                "StoredProcedure" => "CREATE OR ALTER PROCEDURE dbo.MyProc AS BEGIN SELECT 1 END",
                _ => "SELECT 1"
            };
            var entry = new ChangesetEntry {
                Header = "--changeset user:test context:any",
                Comment = "--comment: Test comment",
                Sql = sqlContent
            };
            var settings = CreateSettings(type, "--liquibase formatted sql", [entry]);

            var errors = settings.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        [DataRow("Table")]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_MultipleChangesets_ValidatesAll(string type)
        {
            var sqlContent = type switch {
                "View" => "CREATE OR ALTER VIEW dbo.MyView AS SELECT 1",
                "Function" => "CREATE OR ALTER FUNCTION dbo.MyFunc() RETURNS INT AS BEGIN RETURN 1 END",
                "StoredProcedure" => "CREATE OR ALTER PROCEDURE dbo.MyProc AS BEGIN SELECT 1 END",
                _ => "SELECT 1"
            };
            var entries = new List<ChangesetEntry> {
                new() { Header = "--changeset user:test1", Comment = "--comment: Test 1", Sql = sqlContent },
                new() { Header = "--changeset user:test2", Comment = "--comment: Test 2", Sql = sqlContent },
                new() { Header = "--changeset user:test3", Comment = "--comment: Test 3", Sql = sqlContent }
            };
            var settings = CreateSettings(type, "--liquibase formatted sql", entries);

            var errors = settings.Validate();

            errors.Should().BeEmpty();
        }

        #endregion

        private static IChangesetSettings CreateSettings(string type, string root, List<ChangesetEntry> entries)
        {
            return type switch {
                "Table" => new TableChangesetSettings { ChangesetRoot = root, Changesets = entries },
                "View" => new ViewChangesetSettings { ChangesetRoot = root, Changesets = entries },
                "Function" => new FunctionChangesetSettings { ChangesetRoot = root, Changesets = entries },
                "StoredProcedure" => new StoredProcedureChangesetSettings { ChangesetRoot = root, Changesets = entries },
                _ => throw new ArgumentException($"Unknown type: {type}")
            };
        }
    }
}
