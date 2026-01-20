// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Logging.Console;

namespace Finstar.DatabaseMigration;

public class PlainConsoleFormatter : ConsoleFormatter
{
    public const string FormatterName = "plain";

    private const string AnsiReset = "\x1b[0m";
    private const string AnsiRed = "\x1b[31m";
    private const string AnsiGreen = "\x1b[32m";

    public PlainConsoleFormatter() : base(FormatterName)
    {
    }

    public override void Write<TState>(in LogEntry<TState> logEntry, IExternalScopeProvider? scopeProvider, TextWriter textWriter)
    {
        var message = logEntry.Formatter?.Invoke(logEntry.State, logEntry.Exception);
        if (message is null) {
            return;
        }

        var color = logEntry.LogLevel switch {
            LogLevel.Error or LogLevel.Critical => AnsiRed,
            LogLevel.Information => AnsiGreen,
            _ => string.Empty
        };

        if (!string.IsNullOrEmpty(color)) {
            textWriter.Write(color);
        }

        textWriter.WriteLine(message);

        if (!string.IsNullOrEmpty(color)) {
            textWriter.Write(AnsiReset);
        }
    }
}
