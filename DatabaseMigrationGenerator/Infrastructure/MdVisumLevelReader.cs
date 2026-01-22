// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class MdVisumLevelReader : MdByteArrayReaderBase<MdVisumLevelReader.MdVisumLevelRoot>, IMdVisumLevelReader
    {
        protected override string FileName => "Tables/Data/Md/MdVisumLevel.yaml";
        protected override Dictionary<int, string> GetDictionary(MdVisumLevelRoot root) => root.MdVisumLevel;

        public class MdVisumLevelRoot
        {
            public Dictionary<int, string> MdVisumLevel { get; set; } = new();
        }
    }
}
