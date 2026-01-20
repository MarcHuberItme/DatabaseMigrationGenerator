// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.Metadata
{
    public class TableMetadata(
        string name,
        string description,
        byte tableUsageNo,
        byte domainType,
        string headerTable,
        bool writableForEbanking) : IMetadata
    {
        public string Name { get; } = name;
        public string Description { get; } = description;
        public byte TableUsageNo { get; } = tableUsageNo;
        public byte DomainType { get; } = domainType;
        public string HeaderTable { get; } = headerTable;
        public bool WritableForEbanking { get; } = writableForEbanking;
    }
}