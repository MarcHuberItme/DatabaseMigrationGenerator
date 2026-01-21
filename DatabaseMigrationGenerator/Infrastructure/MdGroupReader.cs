// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class MdGroupReader : IMdGroupReader
    {
        private const string MdGroupFileName = "Tables/Data/Md/MdGroup.yaml";

        public async Task<string[]> ReadAsync(string migrationsPath)
        {
            var filePath = Path.Combine(migrationsPath, MdGroupFileName);

            if (!File.Exists(filePath)) {
                return [];
            }

            var content = await File.ReadAllTextAsync(filePath);
            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .IgnoreUnmatchedProperties()
                .Build();

            var root = deserializer.Deserialize<MdGroupRoot>(content);
            return root.Index.Values.ToArray();
        }

        private class MdGroupRoot
        {
            public Dictionary<string, string> Index { get; set; } = new();
        }
    }
}
