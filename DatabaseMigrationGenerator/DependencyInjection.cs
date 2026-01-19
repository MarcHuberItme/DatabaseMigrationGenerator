// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Microsoft.Extensions.DependencyInjection;

namespace DatabaseMigrationGenerator
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddDatabaseMigrationGenerator(this IServiceCollection services)
        {
            services.AddTransient<IMigrationService, MigrationService>();
            return services;
        }
    }
}