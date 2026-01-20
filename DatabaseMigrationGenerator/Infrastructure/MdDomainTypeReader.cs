// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class MdDomainTypeReader : IMdDomainTypeReader
    {
        private const string MdDomainTypeFileName = "Tables/Data/Md/MdDomainType.yaml";

        public async Task<byte[]> ReadAsync(string migrationsPath)
        {
            var filePath = Path.Combine(migrationsPath, MdDomainTypeFileName);

            if (!File.Exists(filePath)) {
                return [];
            }

            var content = await File.ReadAllTextAsync(filePath);
            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            var root = deserializer.Deserialize<MdDomainTypeRoot>(content);
            return root.MdDomainType.Keys.Select(k => (byte)k).ToArray();
        }

        private class MdDomainTypeRoot
        {
            public Dictionary<int, string> MdDomainType { get; set; } = new();
        }
    }
}
