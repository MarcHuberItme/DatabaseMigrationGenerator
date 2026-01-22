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
    public class SimpleSettingsTests
    {
        private const int MaxNameLength = 128;

        private static ISettings CreateSettings(string type, string name, string? description)
        {
            return type switch {
                "View" => new ViewSettings { Name = name, Description = description },
                "Function" => new FunctionSettings { Name = name, Description = description },
                "StoredProcedure" => new StoredProcedureSettings { Name = name, Description = description },
                _ => throw new ArgumentException($"Unknown type: {type}")
            };
        }

        #region Name Validation

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_NameIsEmpty_ReturnsError(string type)
        {
            var setting = CreateSettings(type, string.Empty, "Valid description");

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("required"));
        }

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_NameExceedsMaxLength_ReturnsError(string type)
        {
            var setting = CreateSettings(type, new string('A', MaxNameLength + 1), "Valid description");

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains($"{MaxNameLength}"));
        }

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_NameStartsWithLowercase_ReturnsNoError(string type)
        {
            var setting = CreateSettings(type, "validName", "Valid description");

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_NameContainsUmlaut_ReturnsError(string type)
        {
            var setting = CreateSettings(type, "Nämë", "Valid description");

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("letters") && e.Contains("digits"));
        }

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_NameContainsSpaces_ReturnsError(string type)
        {
            var setting = CreateSettings(type, "Name With Spaces", "Valid description");

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Name") && e.Contains("letters") && e.Contains("digits"));
        }

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_NameContainsUnderscore_ReturnsNoError(string type)
        {
            var setting = CreateSettings(type, "Valid_Name_123", "Valid description");

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        #endregion

        #region Description Validation

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_DescriptionIsEmpty_ReturnsNoError(string type)
        {
            var setting = CreateSettings(type, "ValidName", string.Empty);

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_DescriptionIsNull_ReturnsNoError(string type)
        {
            var setting = CreateSettings(type, "ValidName", null);

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_DescriptionExceedsMaxLength_ReturnsError(string type)
        {
            var setting = CreateSettings(type, "ValidName", "D" + new string('a', 2000));

            var errors = setting.Validate();

            errors.Should().Contain(e => e.Contains("Description") && e.Contains("2000"));
        }

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_DescriptionContainsUmlaut_ReturnsNoError(string type)
        {
            var setting = CreateSettings(type, "ValidName", "Description with Ümlauts");

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        #endregion

        #region General Validation

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_ValidSettings_ReturnsNoErrors(string type)
        {
            var setting = CreateSettings(type, "ValidName", "Valid description");

            var errors = setting.Validate();

            errors.Should().BeEmpty();
        }

        [TestMethod]
        [DataRow("View")]
        [DataRow("Function")]
        [DataRow("StoredProcedure")]
        public void Validate_MultipleErrors_ReturnsAllErrors(string type)
        {
            var setting = CreateSettings(type, "nämë with spaces", "D" + new string('a', 2000));

            var errors = setting.Validate();

            errors.Should().HaveCount(2);
            errors.Should().Contain(e => e.Contains("Name") && e.Contains("underscores"));
            errors.Should().Contain(e => e.Contains("Description") && e.Contains("2000"));
        }

        #endregion
    }
}
