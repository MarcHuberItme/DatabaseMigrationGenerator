using Finstar.DatabaseMigrationGenerator;
using Finstar.DatabaseMigrationGenerator.Application;
using Finstar.DatabaseMigrationGenerator.Application.Migration;
using Finstar.DatabaseMigrationGenerator.AppSettings;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

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
        
        var miscSettings = scope.ServiceProvider.GetRequiredService<IOptions<MiscSettings>>();
        var migrationsDirectoryPath = miscSettings.Value.MigrationsDirectoryPath(AppContext.BaseDirectory);
        
        var logic = scope.ServiceProvider.GetRequiredService<IMigrationService>();
        
        var command = new CreateChangeSetsCommand(migrationsDirectoryPath);
        await logic.CreateChangeSetsAsync(command);
    }
}