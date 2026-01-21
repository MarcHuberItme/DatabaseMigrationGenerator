// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class MdVisumLevelReader : IMdVisumLevelReader
    {
        private const string MdVisumLevelFileName = "Tables/Data/Md/MdVisumLevel.yaml";

        public async Task<byte[]> ReadAsync(string migrationsPath)
        {
            var filePath = Path.Combine(migrationsPath, MdVisumLevelFileName);

            if (!File.Exists(filePath)) {
                return [];
            }

            var content = await File.ReadAllTextAsync(filePath);
            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            var root = deserializer.Deserialize<MdVisumLevelRoot>(content);
            return root.MdVisumLevel.Keys.Select(k => (byte)k).ToArray();
        }

        private class MdVisumLevelRoot
        {
            public Dictionary<int, string> MdVisumLevel { get; set; } = new();
        }
    }
}
