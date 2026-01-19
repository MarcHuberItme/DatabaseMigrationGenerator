// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace DatabaseMigrationGenerator.Settings
{
    public class LiquibaseSettings
    {
        public bool Run { get; init; }
        public string ExecutablePath { get; init; }
        public string WorkingDirectory { get; init; }
        public string ContextFilter { get; init; }
        public string LabelFilter { get; init; }
    }
}