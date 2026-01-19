using DatabaseMigrationGenerator.Settings;
using Microsoft.Extensions.Options;

namespace DatabaseMigrationGenerator;

public class Test(
    IOptions<LiquibaseSettings> liquibase,
    IOptions<SqlServerSettings> sql,
    IOptions<MiscSettings> misc)
    : ITest
{

    public void Write()
    {
        Console.WriteLine($"Liquibase Settings: Run:{liquibase.Value.Run}");
        Console.WriteLine($"Liquibase Settings: ExecutablePath:{liquibase.Value.ExecutablePath}");
        Console.WriteLine($"Liquibase Settings: WorkingDirectory:{liquibase.Value.WorkingDirectory}");
        Console.WriteLine($"Liquibase Settings: ContextFilter:{liquibase.Value.ContextFilter}");
        Console.WriteLine($"Liquibase Settings: LabelFilter:{liquibase.Value.LabelFilter}");
        
        Console.WriteLine($"SqlServer Settings: HostName:{sql.Value.HostName}");
        Console.WriteLine($"SqlServer Settings: InstanceName:{sql.Value.InstanceName}");
        Console.WriteLine($"SqlServer Settings: DatabaseName:{sql.Value.DatabaseName}");
        Console.WriteLine($"SqlServer Settings: Encrypt:{sql.Value.Encrypt}");
        Console.WriteLine($"SqlServer Settings: TrustedServerCertificate:{sql.Value.TrustedServerCertificate}");
        Console.WriteLine($"SqlServer Settings: IntegratedSecurity:{sql.Value.IntegratedSecurity}");
        
        Console.WriteLine($"Misc Settings: DoNotCreateTriggersForTables:{misc.Value.DoNotCreateTriggersForTables}");
        Console.WriteLine($"Misc Settings: DoNotCreateGetDetailAndGetListForStoredProcedures:{misc.Value.DoNotCreateGetDetailAndGetListForStoredProcedures}");
    }
}