// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public abstract class MdByteArrayReaderBase<TRoot>
    {
        private static readonly IDeserializer Deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        protected abstract string FileName { get; }
        protected abstract Dictionary<int, string> GetDictionary(TRoot root);

        public async Task<byte[]> ReadAsync(string migrationsPath)
        {
            var filePath = Path.Combine(migrationsPath, FileName);

            if (!File.Exists(filePath)) {
                return [];
            }

            var content = await File.ReadAllTextAsync(filePath);
            var root = Deserializer.Deserialize<TRoot>(content);
            return GetDictionary(root).Keys.Select(k => (byte)k).ToArray();
        }
    }
}
