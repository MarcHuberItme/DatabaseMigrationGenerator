// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Domain.SettingsObject
{
    public abstract class SettingsBase : ISettings
    {
        public string SourceFilePath { get; private set; }

        public void MapSourceFilePath(string filePath)
        {
            SourceFilePath =  filePath;
        }
        
        public abstract List<string> Validate();
    }
}