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
        public void Validate_IdIsEmpty_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "TestTable",
                Id = string.Empty
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Id") && e.Contains("GUID"));
        }

        [TestMethod]
        public void Validate_IdIsNotValidGuid_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "TestTable",
                Id = "not-a-valid-guid"
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Id") && e.Contains("GUID"));
        }

        [TestMethod]
        public void Validate_IdIsEmptyGuid_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "TestTable",
                Id = Guid.Empty.ToString()
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Id") && e.Contains("GUID"));
        }

        [TestMethod]
        public void Validate_NameExceedsMaxLength_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ThisNameIsWayTooLongAndExceedsTheLimit",
                Id = Guid.NewGuid().ToString()
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
                Name = "testTable",
                Id = Guid.NewGuid().ToString()
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
                Name = "Täble",
                Id = Guid.NewGuid().ToString()
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
                Name = "Table Name",
                Id = Guid.NewGuid().ToString()
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
                Name = "ValidTableName",
                Id = Guid.NewGuid().ToString()
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
                Name = "täbleWithUmlautAndLowercase",
                Id = "invalid-guid"
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().HaveCount(3);
            errors.Should().Contain(e => e.Contains("uppercase"));
            errors.Should().Contain(e => e.Contains("umlaut"));
            errors.Should().Contain(e => e.Contains("GUID"));
        }
    }
}
