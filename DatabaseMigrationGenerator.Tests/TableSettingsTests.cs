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
    public class TableSettingsTests()
    {
        [TestMethod]
        public void Validate_NameIsEmpty_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = string.Empty
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Name") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_NameExceedsMaxLength_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ThisNameIsWayTooLongAndExceedsTheLimit"
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Name") && e.Contains("30"));
        }

        [TestMethod]
        public void Validate_NameStartsWithLowercase_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "testTable"
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Name") && e.Contains("uppercase"));
        }

        [TestMethod]
        public void Validate_NameContainsUmlaut_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "Täble"
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Name") && e.Contains("umlaut"));
        }

        [TestMethod]
        public void Validate_NameContainsSpaces_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "Table Name"
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Name") && e.Contains("spaces"));
        }

        [TestMethod]
        public void Validate_ValidSettings_ReturnsNoErrors()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidTableName"
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_MultipleErrors_ReturnsAllErrors()
        {
            //arrange
            var setting = new TableSettings {
                Name = "täbleWithUmlautAndLowercase"
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().HaveCount(2);
            errors.Should().Contain(e => e.Contains("uppercase"));
            errors.Should().Contain(e => e.Contains("umlaut"));
        }
    }
}
