// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.AppSettings
{
    public class LiquibaseSettings
    {
        public bool Run { get; init; } = false;
        
        public string ExecutablePath { get; init; } = string.Empty;
        
        public string WorkingDirectory { get; init; } = string.Empty;
        
        public string ContextFilter { get; init; } = string.Empty;
        
        public string LabelFilter { get; init; } = string.Empty;
    }
}