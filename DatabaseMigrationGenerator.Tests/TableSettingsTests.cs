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
        [ClassInitialize]
        public static void ClassInitialize(TestContext _)
        {
            TableSettings.SetValidDomainTypes([10, 20, 30, 40]);
            GenericComponentsSettings.SetValidTableTypes([1, 2, 3, 4, 5, 6]);
        }

        #region Name Validation

        [TestMethod]
        public void Validate_NameIsEmpty_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = string.Empty,
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
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
                Name = "ThisNameIsWayTooLongAndExceedsTheLimit",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
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
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
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
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Name") && e.Contains("letters") && e.Contains("digits"));
        }

        [TestMethod]
        public void Validate_NameContainsSpaces_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "Table Name",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Name") && e.Contains("letters") && e.Contains("digits"));
        }

        #endregion

        #region Description Validation

        [TestMethod]
        public void Validate_DescriptionIsEmpty_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = string.Empty,
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Description") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_DescriptionExceedsMaxLength_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "D" + new string('a', 2000),
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Description") && e.Contains("2000"));
        }

        [TestMethod]
        public void Validate_DescriptionStartsWithLowercase_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "lowercase description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Description") && e.Contains("uppercase"));
        }

        [TestMethod]
        public void Validate_DescriptionContainsUmlaut_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "Description with Ümlauts",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("Description") && e.Contains("umlaut"));
        }

        #endregion

        #region TableUsageNo Validation

        [TestMethod]
        public void Validate_TableUsageNoIsZero_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 0,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("TableUsageNo") && e.Contains("1"));
        }

        [TestMethod]
        public void Validate_TableUsageNoIsTwo_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 2,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("TableUsageNo") && e.Contains("1"));
        }

        #endregion

        #region DomainType Validation

        [TestMethod]
        public void Validate_DomainTypeIsZero_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 0,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("DomainType") && e.Contains("10, 20, 30, 40"));
        }

        [TestMethod]
        public void Validate_DomainTypeIsInvalid_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 15,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("DomainType") && e.Contains("10, 20, 30, 40"));
        }

        [TestMethod]
        [DataRow((byte)10)]
        [DataRow((byte)20)]
        [DataRow((byte)30)]
        [DataRow((byte)40)]
        public void Validate_DomainTypeIsValid_ReturnsNoError(byte domainType)
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = domainType,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().NotContain(e => e.Contains("DomainType"));
        }

        #endregion

        #region General Validation

        [TestMethod]
        public void Validate_ValidSettings_ReturnsNoErrors()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidTableName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 1 }
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
                Name = "täble",
                Description = "löwercase",
                TableUsageNo = 0,
                DomainType = 0
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().HaveCountGreaterThanOrEqualTo(6);
        }

        #endregion

        #region GenericComponents Validation

        [TestMethod]
        public void Validate_GenericComponentsIsNull_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = null
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("GenericComponents") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_TableTypeIsNull_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = null }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("TableType") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_TableTypeIsInvalid_ReturnsError()
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = 99 }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().Contain(e => e.Contains("TableType") && e.Contains("1, 2, 3, 4, 5, 6"));
        }

        [TestMethod]
        [DataRow((byte)1)]
        [DataRow((byte)2)]
        [DataRow((byte)3)]
        [DataRow((byte)4)]
        [DataRow((byte)5)]
        [DataRow((byte)6)]
        public void Validate_TableTypeIsValid_ReturnsNoError(byte tableType)
        {
            //arrange
            var setting = new TableSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                WritableForEbanking = false,
                GenericComponents = new GenericComponentsSettings { TableType = tableType }
            };

            //act
            var errors = setting.Validate();

            //assert
            errors.Should().NotContain(e => e.Contains("TableType"));
        }

        #endregion
    }
}
