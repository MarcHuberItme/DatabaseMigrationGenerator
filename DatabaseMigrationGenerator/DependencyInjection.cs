// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Application.Changeset;
using Finstar.DatabaseMigrationGenerator.Application.Metadata;
using Finstar.DatabaseMigrationGenerator.Application.Migration;
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
            services.AddTransient<ISettingsReader, SettingsReader>();
            services.AddTransient<IHeaderTableSettingsReader, HeaderTableSettingsReader>();
            services.AddTransient<IMdDomainTypeReader, MdDomainTypeReader>();
            services.AddTransient<IMdTableTypeReader, MdTableTypeReader>();
            services.AddTransient<IMdVisumLevelReader, MdVisumLevelReader>();
            services.AddTransient<IMdCacheLevelReader, MdCacheLevelReader>();
            services.AddTransient<IMdGroupReader, MdGroupReader>();
            services.AddTransient<IMetadataBuilder, MetadataBuilder>();
            services.AddTransient<IMetadataGenerationService, MetadataGenerationService>();
            services.AddTransient<IChangesetReader, ChangesetReader>();
            services.AddTransient<IChangesetGenerationService, ChangesetGenerationService>();

            return services;
        }
    }
}