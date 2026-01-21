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
    public class ColumnSettingsTests
    {
        private static GenericControlsSettings CreateValidGenericControls()
        {
            return new GenericControlsSettings {
                MultiLine = false,
                RefTable = "",
                RefField = "",
                HasDetailBtn = false,
                VisNumber = 0,
                DefColumnPos = 0,
                NoUpdatePos = 0,
                IsOnlyForMig = false,
                IsNoUpdate = false,
                IsIdentity = false
            };
        }

        private static ColumnSettings CreateValidColumnSettings()
        {
            return new ColumnSettings {
                Name = "ValidColumn",
                Description = "Valid description",
                GenericControls = CreateValidGenericControls()
            };
        }

        #region Name Validation

        [TestMethod]
        public void Validate_NameIsEmpty_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = string.Empty,
                Description = "Valid description",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_NameExceedsMaxLength_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "ThisNameIsWayTooLongAndExceedsTheLimit",
                Description = "Valid description",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("30"));
        }

        [TestMethod]
        public void Validate_NameStartsWithLowercase_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "testColumn",
                Description = "Valid description",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("uppercase"));
        }

        [TestMethod]
        public void Validate_NameContainsUmlaut_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "Cölumn",
                Description = "Valid description",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("letters") && e.Contains("digits"));
        }

        [TestMethod]
        public void Validate_NameContainsSpaces_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "Column Name",
                Description = "Valid description",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("letters") && e.Contains("digits"));
        }

        #endregion

        #region Description Validation

        [TestMethod]
        public void Validate_DescriptionIsEmpty_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = string.Empty,
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Description") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_DescriptionExceedsMaxLength_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "D" + new string('a', 2000),
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Description") && e.Contains("2000"));
        }

        [TestMethod]
        public void Validate_DescriptionStartsWithLowercase_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "lowercase description",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Description") && e.Contains("uppercase"));
        }

        [TestMethod]
        public void Validate_DescriptionContainsUmlaut_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "Description with Ümlauts",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Description") && e.Contains("umlaut"));
        }

        #endregion

        #region GenericControls Validation

        [TestMethod]
        public void Validate_GenericControlsIsNull_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "Valid description",
                GenericControls = null
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("GenericControls") && e.Contains("required"));
        }

        #endregion

        #region General Validation

        [TestMethod]
        public void Validate_ValidSettings_ReturnsNoErrors()
        {
            var setting = CreateValidColumnSettings();

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_MultipleErrors_ReturnsAllErrors()
        {
            var setting = new ColumnSettings {
                Name = "cölumn",
                Description = "löwercase"
            };

            var errors = setting.Validate();

            errors.Should().HaveCountGreaterThanOrEqualTo(3);
        }

        #endregion
    }
}
