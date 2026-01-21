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
    public class FrontEndViewSettingsTests
    {
        private const string ValidGroupId = "55CF3376-AD4B-4C80-836A-4B8403901D1A";

        [ClassInitialize]
        public static void ClassInitialize(TestContext _)
        {
            // FrontEndViewSettings uses validators from TableSettings and GenericComponentsSettings
            TableSettings.SetValidDomainTypes([10, 20, 30, 40]);
            TableSettings.SetValidHeaderTables(["HdStandard", "HdMessageStore"]);
            GenericComponentsSettings.SetValidTableTypes([1, 2, 3, 4, 5, 6]);
            GenericComponentsSettings.SetValidVisumLevels([1, 2, 4, 8]);
            GenericComponentsSettings.SetValidCacheLevels([1, 2, 3, 4]);
            GenericComponentsSettings.SetValidGroupIds([ValidGroupId, "6343CC8C-363D-4CCE-968C-FE33E28066E0"]);
        }

        private static NavigationSettings CreateValidNavigation()
        {
            return new NavigationSettings {
                IsNavigationRoot = false,
                RootTable = "",
                ParentTable = "",
                ParentIdField = "",
                ParentRelationField = "",
                ApplicationKey = "",
                NavigationConditionField = "",
                IsSharedNode = false,
                IsHiddenNode = false
            };
        }

        private static FrontEndViewGenericComponentsSettings CreateValidGenericComponents()
        {
            return new FrontEndViewGenericComponentsSettings {
                TableType = 5,
                GroupId = ValidGroupId,
                DefArchive = true,
                VisumNumber = 0,
                VisumLevel = 1,
                HasAsText = true,
                CacheLevel = 1,
                PhysicalDelete = false,
                IsGroupable = false,
                DescField = "",
                ChangeNoticeLevel = 0,
                Navigation = CreateValidNavigation()
            };
        }

        private static FrontEndViewSettings CreateValidFrontEndViewSettings()
        {
            return new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                HeaderTable = "HdStandard",
                GenericComponents = CreateValidGenericComponents()
            };
        }

        #region Name Validation

        [TestMethod]
        public void Validate_NameIsEmpty_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = string.Empty,
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_NameExceedsMaxLength_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ThisNameIsWayTooLongAndExceedsTheLimit",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("30"));
        }

        [TestMethod]
        public void Validate_NameStartsWithLowercase_ReturnsNoError()
        {
            var setting = new FrontEndViewSettings {
                Name = "testFrontEndView",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                HeaderTable = "HdStandard",
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_NameContainsUmlaut_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "Vïew",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("letters") && e.Contains("digits"));
        }

        [TestMethod]
        public void Validate_NameContainsSpaces_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "FrontEnd View",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("letters") && e.Contains("digits"));
        }

        #endregion

        #region Description Validation

        [TestMethod]
        public void Validate_DescriptionIsEmpty_ReturnsNoError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = string.Empty,
                TableUsageNo = 1,
                DomainType = 10,
                HeaderTable = "HdStandard",
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_DescriptionExceedsMaxLength_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "D" + new string('a', 2000),
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Description") && e.Contains("2000"));
        }

        #endregion

        #region TableUsageNo Validation

        [TestMethod]
        public void Validate_TableUsageNoIsZero_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 0,
                DomainType = 10,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("TableUsageNo") && e.Contains("1"));
        }

        [TestMethod]
        public void Validate_TableUsageNoIsTwo_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 2,
                DomainType = 10,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("TableUsageNo") && e.Contains("1"));
        }

        #endregion

        #region DomainType Validation

        [TestMethod]
        public void Validate_DomainTypeIsZero_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 0,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("DomainType") && e.Contains("10, 20, 30, 40"));
        }

        [TestMethod]
        public void Validate_DomainTypeIsInvalid_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 15,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("DomainType") && e.Contains("10, 20, 30, 40"));
        }

        [TestMethod]
        [DataRow((byte)10)]
        [DataRow((byte)20)]
        [DataRow((byte)30)]
        [DataRow((byte)40)]
        public void Validate_DomainTypeIsValid_ReturnsNoError(byte domainType)
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = domainType,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().NotContain(e => e.Contains("DomainType"));
        }

        #endregion

        #region HeaderTable Validation

        [TestMethod]
        public void Validate_HeaderTableIsEmpty_ReturnsNoError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                HeaderTable = string.Empty,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_HeaderTableIsInvalid_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                HeaderTable = "InvalidHeaderTable",
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("HeaderTable") && e.Contains("HdStandard, HdMessageStore"));
        }

        [TestMethod]
        [DataRow("HdStandard")]
        [DataRow("HdMessageStore")]
        public void Validate_HeaderTableIsValid_ReturnsNoError(string headerTable)
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                HeaderTable = headerTable,
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().NotContain(e => e.Contains("HeaderTable"));
        }

        [TestMethod]
        public void Validate_HeaderTableIsCaseInsensitive_ReturnsNoError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                HeaderTable = "hdstandard",
                GenericComponents = CreateValidGenericComponents()
            };

            var errors = setting.Validate();

            errors.Should().NotContain(e => e.Contains("HeaderTable"));
        }

        #endregion

        #region GenericComponents Validation

        [TestMethod]
        public void Validate_GenericComponentsIsNull_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                HeaderTable = "HdStandard",
                GenericComponents = null
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("GenericComponents") && e.Contains("required"));
        }

        #endregion

        #region TableType Validation

        [TestMethod]
        public void Validate_TableTypeIsNull_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = null,
                    GroupId = ValidGroupId,
                    DefArchive = true,
                    VisumLevel = 1,
                    HasAsText = true,
                    CacheLevel = 1,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("TableType") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_TableTypeIsInvalid_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 99,
                    GroupId = ValidGroupId,
                    DefArchive = true,
                    VisumLevel = 1,
                    HasAsText = true,
                    CacheLevel = 1,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

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
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = tableType,
                    GroupId = ValidGroupId,
                    DefArchive = true,
                    VisumLevel = 1,
                    HasAsText = true,
                    CacheLevel = 1,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().NotContain(e => e.Contains("TableType"));
        }

        #endregion

        #region GroupId Validation

        [TestMethod]
        public void Validate_GroupIdIsEmpty_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = string.Empty,
                    DefArchive = true,
                    VisumLevel = 1,
                    HasAsText = true,
                    CacheLevel = 1,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("GroupId") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_GroupIdIsInvalid_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = "invalid-guid",
                    DefArchive = true,
                    VisumLevel = 1,
                    HasAsText = true,
                    CacheLevel = 1,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("GroupId") && e.Contains("valid group GUID"));
        }

        #endregion

        #region VisumNumber Validation

        [TestMethod]
        public void Validate_VisumNumberIsInvalid_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = ValidGroupId,
                    VisumNumber = 99,
                    VisumLevel = 1,
                    CacheLevel = 1,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("VisumNumber") && e.Contains("0, 1, 85"));
        }

        [TestMethod]
        [DataRow((byte)0)]
        [DataRow((byte)1)]
        [DataRow((byte)85)]
        public void Validate_VisumNumberIsValid_ReturnsNoError(byte visumNumber)
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = ValidGroupId,
                    VisumNumber = visumNumber,
                    VisumLevel = 1,
                    CacheLevel = 1,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().NotContain(e => e.Contains("VisumNumber"));
        }

        #endregion

        #region VisumLevel Validation

        [TestMethod]
        public void Validate_VisumLevelIsNull_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = ValidGroupId,
                    DefArchive = true,
                    VisumLevel = null,
                    HasAsText = true,
                    CacheLevel = 1,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("VisumLevel") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_VisumLevelIsInvalid_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = ValidGroupId,
                    DefArchive = true,
                    VisumLevel = 99,
                    HasAsText = true,
                    CacheLevel = 1,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("VisumLevel") && e.Contains("1, 2, 4, 8"));
        }

        [TestMethod]
        [DataRow((byte)1)]
        [DataRow((byte)2)]
        [DataRow((byte)4)]
        [DataRow((byte)8)]
        public void Validate_VisumLevelIsValid_ReturnsNoError(byte visumLevel)
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = ValidGroupId,
                    DefArchive = true,
                    VisumLevel = visumLevel,
                    HasAsText = true,
                    CacheLevel = 1,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().NotContain(e => e.Contains("VisumLevel"));
        }

        #endregion

        #region CacheLevel Validation

        [TestMethod]
        public void Validate_CacheLevelIsNull_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = ValidGroupId,
                    DefArchive = true,
                    VisumLevel = 1,
                    HasAsText = true,
                    CacheLevel = null,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("CacheLevel") && e.Contains("required"));
        }

        [TestMethod]
        public void Validate_CacheLevelIsInvalid_ReturnsError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = ValidGroupId,
                    DefArchive = true,
                    VisumLevel = 1,
                    HasAsText = true,
                    CacheLevel = 99,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("CacheLevel") && e.Contains("1, 2, 3, 4"));
        }

        [TestMethod]
        [DataRow((byte)1)]
        [DataRow((byte)2)]
        [DataRow((byte)3)]
        [DataRow((byte)4)]
        public void Validate_CacheLevelIsValid_ReturnsNoError(byte cacheLevel)
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = ValidGroupId,
                    DefArchive = true,
                    VisumLevel = 1,
                    HasAsText = true,
                    CacheLevel = cacheLevel,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = CreateValidNavigation()
                }
            };

            var errors = setting.Validate();

            errors.Should().NotContain(e => e.Contains("CacheLevel"));
        }

        #endregion

        #region Navigation Validation

        [TestMethod]
        public void Validate_NavigationIsNull_ReturnsNoError()
        {
            var setting = new FrontEndViewSettings {
                Name = "ValidName",
                Description = "Valid description",
                TableUsageNo = 1,
                DomainType = 10,
                HeaderTable = "HdStandard",
                GenericComponents = new FrontEndViewGenericComponentsSettings {
                    TableType = 5,
                    GroupId = ValidGroupId,
                    DefArchive = true,
                    VisumLevel = 1,
                    HasAsText = true,
                    CacheLevel = 1,
                    PhysicalDelete = false,
                    IsGroupable = false,
                    Navigation = null
                }
            };

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        #endregion

        #region General Validation

        [TestMethod]
        public void Validate_ValidSettings_ReturnsNoErrors()
        {
            var setting = CreateValidFrontEndViewSettings();

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        public void Validate_MultipleErrors_ReturnsAllErrors()
        {
            var setting = new FrontEndViewSettings {
                Name = "vïew",
                Description = "Valid",
                TableUsageNo = 0,
                DomainType = 0
            };

            var errors = setting.Validate();

            errors.Should().HaveCountGreaterThanOrEqualTo(4);
            errors.Should().Contain(e => e.Contains("Name") && e.Contains("underscores"));
            errors.Should().Contain(e => e.Contains("TableUsageNo"));
            errors.Should().Contain(e => e.Contains("DomainType"));
            errors.Should().Contain(e => e.Contains("GenericComponents"));
        }

        #endregion
    }
}
