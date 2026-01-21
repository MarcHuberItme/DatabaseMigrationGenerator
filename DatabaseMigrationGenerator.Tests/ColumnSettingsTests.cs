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
        public void Validate_NameStartsWithLowercase_ReturnsNoError()
        {
            var setting = new ColumnSettings {
                Name = "testColumn",
                Description = "Valid description",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_NameWithUnderscore_ReturnsNoError()
        {
            var setting = new ColumnSettings {
                Name = "Test_Column",
                Description = "Valid description",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
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

            errors.Should().Contain(e => e.Contains("Cölumn") && e.Contains("underscores"));
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

            errors.Should().Contain(e => e.Contains("Column Name") && e.Contains("underscores"));
        }

        #endregion

        #region Description Validation

        [TestMethod]
        public void Validate_DescriptionIsEmpty_ReturnsNoError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = string.Empty,
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
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

            errors.Should().Contain(e => e.Contains("ValidColumn") && e.Contains("Description") && e.Contains("2000"));
        }

        [TestMethod]
        public void Validate_DescriptionStartsWithLowercase_ReturnsNoError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "lowercase description",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_DescriptionContainsUmlaut_ReturnsNoError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "Description with Ümlauts",
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        #endregion

        #region MinValue Validation

        [TestMethod]
        public void Validate_MinValueExceedsMaxLength_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "Valid description",
                MinValue = new string('1', 31),
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("MinValue") && e.Contains("30"));
        }

        [TestMethod]
        public void Validate_MinValueWithinLimit_ReturnsNoError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "Valid description",
                MinValue = new string('1', 30),
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().NotContain(e => e.Contains("MinValue"));
        }

        #endregion

        #region MaxValue Validation

        [TestMethod]
        public void Validate_MaxValueExceedsMaxLength_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "Valid description",
                MaxValue = new string('9', 31),
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("MaxValue") && e.Contains("30"));
        }

        [TestMethod]
        public void Validate_MaxValueWithinLimit_ReturnsNoError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "Valid description",
                MaxValue = new string('9', 30),
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().NotContain(e => e.Contains("MaxValue"));
        }

        #endregion

        #region DefaultValue Validation

        [TestMethod]
        public void Validate_DefaultValueExceedsMaxLength_ReturnsError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "Valid description",
                DefaultValue = new string('x', 31),
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("DefaultValue") && e.Contains("30"));
        }

        [TestMethod]
        public void Validate_DefaultValueWithinLimit_ReturnsNoError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "Valid description",
                DefaultValue = new string('x', 30),
                GenericControls = CreateValidGenericControls()
            };

            var errors = setting.Validate();

            errors.Should().NotContain(e => e.Contains("DefaultValue"));
        }

        #endregion

        #region GenericControls Validation

        [TestMethod]
        public void Validate_GenericControlsIsNull_ReturnsNoError()
        {
            var setting = new ColumnSettings {
                Name = "ValidColumn",
                Description = "Valid description",
                GenericControls = null
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
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
                Description = "Description"
            };

            var errors = setting.Validate();

            errors.Should().HaveCount(1);
            errors.Should().Contain(e => e.Contains("cölumn") && e.Contains("underscores"));
        }

        #endregion
    }
}
