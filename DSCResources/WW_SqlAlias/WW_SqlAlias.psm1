function Get-TargetResource {
	param(
		[ValidateSet("Present", "Absent")]
                [string]$Ensure = "Present",
        
                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                [string]$AliasName,
        
                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                [string]$SqlServerName,
        
                [uint32]$Port
	)
        $getTargetResourceResult = $null
        $alias = "DBMSSOCN,$SqlServerName"
        if($Port -ne 0) {
                $alias += ",$Port"
        }
        
        $Data = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\MSSQLServer\Client\ConnectTo' -Name $AliasName -ea 0 | select -ExpandProperty $AliasName
        if($Data -ne $null){
                $arr = $Data.Split(',')
                if($arr.lenght -eq 2){
                        $port = $null
                } 
                else {
                        $port = $arr[2]
                }
                return @{
                                AliasName = $AliasName;
                                SqlServerName = $arr[1];
                                Port = [System.Convert]::ToUint32($port);
                        }  
                
        }
        
        return $null;
}

function Set-TargetResource {
	param(
		[ValidateSet("Present", "Absent")]
                [string]$Ensure = "Present",
        
                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                [string]$AliasName,
        
                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                [string]$SqlServerName,
        
                [uint32]$Port
	)

        $alias = "DBMSSOCN,$SqlServerName"
        if($Port -ne 0) {
                $alias += ",$Port"
        }
        
        $Client = Get-Item 'HKLM:\SOFTWARE\Microsoft\MSSQLServer\Client\ConnectTo' -ea 0
        if($Client  -eq $null){
                $Client = New-Item 'HKLM:\SOFTWARE\Microsoft\MSSQLServer\Client\ConnectTo'
        }
        
        $Data = New-ItemProperty 'HKLM:\SOFTWARE\Microsoft\MSSQLServer\Client\ConnectTo' -Name $AliasName -Value $alias -PropertyType "String" -Force -ErrorAction SilentlyContinue

}

function Test-TargetResource {
	param(
		[ValidateSet("Present", "Absent")]
                [string]$Ensure = "Present",
        
                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                [string]$AliasName,
        
                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                [string]$SqlServerName,
        
                [uint32]$Port
	)
        
        $alias = "DBMSSOCN,$SqlServerName"
        if($Port -ne 0) {
                $alias += ",$Port"
        }
              
        $Data = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\MSSQLServer\Client\ConnectTo' -Name $AliasName -ea 0 | select -ExpandProperty $AliasName
        if($Data -eq $alias){
            return $true    
        }
        return $false
}

Export-ModuleMember -Function *-TargetResource