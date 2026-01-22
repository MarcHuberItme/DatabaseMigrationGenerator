// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

namespace Finstar.DatabaseMigrationGenerator.Application.Output
{
    public interface IConsoleOutput
    {
        void Write(string message);
        void WriteLine(string message = "");
        void WriteProgress(string message);
        void WriteSuccess(string message);
        void WriteError(string message);
        void WriteSection(string title);
    }
}
