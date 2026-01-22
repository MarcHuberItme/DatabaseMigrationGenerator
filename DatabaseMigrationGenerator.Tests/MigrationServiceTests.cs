using Finstar.DatabaseMigrationGenerator.Application.Migration;
using FluentAssertions;
using Microsoft.Extensions.DependencyInjection;

namespace Finstar.DatabaseMigrationGenerator.Tests;

[TestClass]
public class MigrationServiceTests : TestsBase
{
    [TestMethod]
    public async Task Test_WithInvalidPath_ThrowsException()
    {
        //arrange
        var uut = ServiceProvider.GetRequiredService<IMigrationService>();
        var command = new CreateChangeSetsCommand("nonexistent_path");

        //act
        Func<Task> act = async () => await uut.CreateChangeSetsAsync(command);

        //assert
        await act.Should().ThrowAsync<DirectoryNotFoundException>();
    }
}
