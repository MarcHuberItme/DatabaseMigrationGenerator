// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class MdCacheLevelReader : IMdCacheLevelReader
    {
        private const string MdCacheLevelFileName = "Tables/Data/Md/MdCacheLevel.yaml";

        public async Task<byte[]> ReadAsync(string migrationsPath)
        {
            var filePath = Path.Combine(migrationsPath, MdCacheLevelFileName);

            if (!File.Exists(filePath)) {
                return [];
            }

            var content = await File.ReadAllTextAsync(filePath);
            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            var root = deserializer.Deserialize<MdCacheLevelRoot>(content);
            return root.MdCacheLevel.Keys.Select(k => (byte)k).ToArray();
        }

        private class MdCacheLevelRoot
        {
            public Dictionary<int, string> MdCacheLevel { get; set; } = new();
        }
    }
}
