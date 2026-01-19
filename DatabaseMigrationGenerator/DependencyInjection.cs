// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using DatabaseMigrationGenerator;
using DatabaseMigrationGenerator.Settings;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Finstar.DatabaseMigrationGenerator
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddDatabaseMigrationGenerator(
            this IServiceCollection services,
            IConfiguration configuration)
        {
            services.Configure<LiquibaseSettings>(configuration.GetSection("Liquibase"));
            services.Configure<SqlServerSettings>(configuration.GetSection("SqlServer"));
            services.Configure<MiscSettings>(configuration.GetSection("Misc"));
            
            services.AddTransient<IMigrationService, MigrationService>();
            return services;
        }
    }
}