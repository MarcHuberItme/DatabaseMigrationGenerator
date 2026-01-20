// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.AppSettings
{
    public class SqlServerSettings
    {
        public string HostName { get; init; }
        public string InstanceName { get; init; }
        public string DatabaseName { get; init; }
        public bool Encrypt { get; init; }
        public bool TrustedServerCertificate { get; init; }
        public bool IntegratedSecurity { get; init; }
    }
}