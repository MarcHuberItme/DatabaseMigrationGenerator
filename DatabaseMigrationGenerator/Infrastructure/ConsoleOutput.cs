// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Finstar.DatabaseMigrationGenerator.Application.Output;

namespace Finstar.DatabaseMigrationGenerator.Infrastructure
{
    public class ConsoleOutput : IConsoleOutput
    {
        public void Write(string message)
        {
            Console.Write(message);
        }

        public void WriteLine(string message = "")
        {
            Console.WriteLine(message);
        }

        public void WriteProgress(string message)
        {
            Console.Write($"\r{message}");
        }

        public void WriteSuccess(string message)
        {
            Console.ForegroundColor = ConsoleColor.DarkGreen;
            Console.WriteLine(message);
            Console.ResetColor();
        }

        public void WriteError(string message)
        {
            Console.ForegroundColor = ConsoleColor.DarkRed;
            Console.WriteLine(message);
            Console.ResetColor();
        }

        public void WriteSection(string title)
        {
            Console.WriteLine($"=== {title} ===");
        }
    }
}
