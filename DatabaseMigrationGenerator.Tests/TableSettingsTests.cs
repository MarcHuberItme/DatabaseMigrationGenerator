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
        public void Validate_NameIsEmpty_ThrowException()
        {
            //arrange
            var setting = new TableSettings {
                Name = string.Empty
            };
        
            //act
            Action act = () => setting.Validate();

            //assert
            act.Should().Throw();
        }
    }
}