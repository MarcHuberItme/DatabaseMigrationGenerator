// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.AppSettings
{
    public class SqlServerSettings
    {
        public string HostName { get; init; } = string.Empty;
        
        public string InstanceName { get; init; } = string.Empty;
        
        public string DatabaseName { get; init; } = string.Empty;
        
        public bool Encrypt { get; init; }
        
        public bool TrustedServerCertificate { get; init; }
        
        public bool IntegratedSecurity { get; init; }
    }
}