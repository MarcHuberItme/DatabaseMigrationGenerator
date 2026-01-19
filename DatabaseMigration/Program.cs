using Finstar.DatabaseMigrationGenerator;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace Finstar.DatabaseMigration;

class Program
{
    static async Task Main(string[] args)
    {
        using var host = Host.CreateDefaultBuilder(args)
            .ConfigureServices((ctx, services) =>
            {
                services.AddDatabaseMigrationGenerator(ctx.Configuration);
            })
            .ConfigureLogging(logging =>
            {
                logging.ClearProviders();
                logging.AddConsole();
            })
            .Build();

        using var scope = host.Services.CreateScope();
        var logic = scope.ServiceProvider.GetRequiredService<IMigrationService>();
        await logic.CreateChangeSetsAsync();
    }
}