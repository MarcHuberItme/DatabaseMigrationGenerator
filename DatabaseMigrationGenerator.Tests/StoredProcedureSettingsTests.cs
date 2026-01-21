// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Domain.SettingsObject;
using FluentAssertions;

namespace Finstar.DatabaseMigrationGenerator.Tests
{
    [TestClass]
    public class StoredProcedureSettingsTests
    {
        private static StoredProcedureSettings CreateValidStoredProcedureSettings()
        {
            return new StoredProcedureSettings {
                Name = "ValidProcName",
                Description = "Valid description"
            };
        }

        #region Name Validation

        [TestMethod]
        public void Validate_NameIsEmpty_ReturnsError()
        {
            var setting = new StoredProcedureSettings {
                Name = string.Empty,
                Description = "Valid description"
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_NameExceedsMaxLength_ReturnsError()
        {
            var setting = new StoredProcedureSettings {
                Name = new string('A', 129),
                Description = "Valid description"
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("128"));
        }

        [TestMethod]
        public void Validate_NameStartsWithLowercase_ReturnsNoError()
        {
            var setting = new StoredProcedureSettings {
                Name = "testProc",
                Description = "Valid description"
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_NameContainsUmlaut_ReturnsError()
        {
            var setting = new StoredProcedureSettings {
                Name = "Pröc",
                Description = "Valid description"
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("letters") && e.Contains("digits"));
        }

        [TestMethod]
        public void Validate_NameContainsSpaces_ReturnsError()
        {
            var setting = new StoredProcedureSettings {
                Name = "Proc Name",
                Description = "Valid description"
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("letters") && e.Contains("digits"));
        }

        [TestMethod]
        public void Validate_NameContainsUnderscore_ReturnsNoError()
        {
            var setting = new StoredProcedureSettings {
                Name = "Proc_Name_123",
                Description = "Valid description"
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        #endregion

        #region Description Validation

        [TestMethod]
        public void Validate_DescriptionIsEmpty_ReturnsNoError()
        {
            var setting = new StoredProcedureSettings {
                Name = "ValidProcName",
                Description = string.Empty
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_DescriptionIsNull_ReturnsNoError()
        {
            var setting = new StoredProcedureSettings {
                Name = "ValidProcName",
                Description = null
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_DescriptionExceedsMaxLength_ReturnsError()
        {
            var setting = new StoredProcedureSettings {
                Name = "ValidProcName",
                Description = "D" + new string('a', 2000)
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Description") && e.Contains("2000"));
        }

        [TestMethod]
        public void Validate_DescriptionContainsUmlaut_ReturnsNoError()
        {
            var setting = new StoredProcedureSettings {
                Name = "ValidProcName",
                Description = "Description with Ümlauts"
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        #endregion

        #region General Validation

        [TestMethod]
        public void Validate_ValidSettings_ReturnsNoErrors()
        {
            var setting = CreateValidStoredProcedureSettings();

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_MultipleErrors_ReturnsAllErrors()
        {
            var setting = new StoredProcedureSettings {
                Name = "pröc name",
                Description = "D" + new string('a', 2000)
            };

            var errors = setting.Validate();

            errors.Should().HaveCount(2);
            errors.Should().Contain(e => e.Contains("Name") && e.Contains("underscores"));
            errors.Should().Contain(e => e.Contains("Description") && e.Contains("2000"));
        }

        #endregion
    }
}
