# xWWDSCHelpers

The **xWWDSCHelpers** module is a collection of DSC Resources.

**All of the resources in the DSC Modulet are provided AS IS**

Details
-------

**xSqlAlias** resource has following properties

- **AliasName**: Name of the SQL Alias (required)
- **SqlServerName**: Name of the SQL Server (required)
- **Port**: The Port to use (optional)
- **Ensure**: *Present* or *Absent* Determines whether the setting should be applied or removed (not implemented)


Examples
--------


```powershell
Configuration SqlAliasTest{
    Import-DscResource -ModuleName xWWDSCHelpers
    
   
    Node "localhost" {
         xSqlAlias Alias1 {
            AliasName = "Test"
            SqlServerName = "Server1"
        }

        xSqlAlias Alias2 {
            AliasName = "TestWithPort"
            SqlServerName = "Server1"
            Port=14001
        }
        
    }
}
```

