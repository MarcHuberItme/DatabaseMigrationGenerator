// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class MdTableTypeReader : MdByteArrayReaderBase<MdTableTypeReader.MdTableTypeRoot>, IMdTableTypeReader
    {
        protected override string FileName => "Tables/Data/Md/MdTableType.yaml";
        protected override Dictionary<int, string> GetDictionary(MdTableTypeRoot root) => root.MdTableType;

        public class MdTableTypeRoot
        {
            public Dictionary<int, string> MdTableType { get; set; } = new();
        }
    }
}
