// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Abstractions;

namespace Finstar.DatabaseMigrationGenerator.Tests
{
    public class TestsBase
    {
        protected ServiceProvider ServiceProvider = null!;
        protected IConfiguration Configuration = null!;
        
        [TestInitialize]
        public void Setup()
        {
            var defaults = new Dictionary<string, string?>
            {
                ["Liquibase:Run"] = "true",
                ["Liquibase:ExecutablePath"] = "liquibase.exe",
                ["Liquibase:WorkingDirectory"] = ".",
                ["Liquibase:ContextFilter"] = "test",
                ["Liquibase:LabelFilter"] = "",

               
            };

            Configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(defaults)
                .Build();

            var services = new ServiceCollection();

            services.AddSingleton<ILoggerFactory, NullLoggerFactory>();
            services.AddSingleton(typeof(ILogger<>), typeof(NullLogger<>));
            services.AddDatabaseMigrationGenerator(Configuration);

            ServiceProvider = services.BuildServiceProvider();
        }
    }
}