// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class MdTableTypeReader : IMdTableTypeReader
    {
        private const string MdTableTypeFileName = "Tables/Data/Md/MdTableType.yaml";

        public async Task<byte[]> ReadAsync(string migrationsPath)
        {
            var filePath = Path.Combine(migrationsPath, MdTableTypeFileName);

            if (!File.Exists(filePath)) {
                return [];
            }

            var content = await File.ReadAllTextAsync(filePath);
            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            var root = deserializer.Deserialize<MdTableTypeRoot>(content);
            return root.MdTableType.Keys.Select(k => (byte)k).ToArray();
        }

        private class MdTableTypeRoot
        {
            public Dictionary<int, string> MdTableType { get; set; } = new();
        }
    }
}
