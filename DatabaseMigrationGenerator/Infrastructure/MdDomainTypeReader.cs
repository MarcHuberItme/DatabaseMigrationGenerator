// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class MdDomainTypeReader : MdByteArrayReaderBase<MdDomainTypeReader.MdDomainTypeRoot>, IMdDomainTypeReader
    {
        protected override string FileName => "Tables/Data/Md/MdDomainType.yaml";
        protected override Dictionary<int, string> GetDictionary(MdDomainTypeRoot root) => root.MdDomainType;

        public class MdDomainTypeRoot
        {
            public Dictionary<int, string> MdDomainType { get; set; } = new();
        }
    }
}
