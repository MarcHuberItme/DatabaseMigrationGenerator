// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class MdCacheLevelReader : MdByteArrayReaderBase<MdCacheLevelReader.MdCacheLevelRoot>, IMdCacheLevelReader
    {
        protected override string FileName => "Tables/Data/Md/MdCacheLevel.yaml";
        protected override Dictionary<int, string> GetDictionary(MdCacheLevelRoot root) => root.MdCacheLevel;

        public class MdCacheLevelRoot
        {
            public Dictionary<int, string> MdCacheLevel { get; set; } = new();
        }
    }
}
