// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Application;
using Finstar.DatabaseMigrationGenerator.AppSettings;
using Finstar.DatabaseMigrationGenerator.Infrastructure;
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
            services.AddTransient<IDatabaseObjectSettingsReader, DatabaseObjectSettingsReader>();
            return services;
        }
    }
}