using Finstar.DatabaseMigrationGenerator.Application;
using FluentAssertions;
using Microsoft.Extensions.DependencyInjection;

namespace Finstar.DatabaseMigrationGenerator.Tests;

[TestClass]
public class MigrationServiceTests : TestsBase
{
    [TestMethod]
    public async Task Test()
    {
        //arrange
        var uut = ServiceProvider.GetRequiredService<IMigrationService>();
        var command = new CreateChangeSetsCommand("test");
        
        //act
        Func<Task> act = async () => await uut.CreateChangeSetsAsync(command);

        //assert
        await act.Should().NotThrowAsync();
    }
}