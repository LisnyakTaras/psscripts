# Скрипт ищет в Event Logs раздел-System, группа-Microsoft-Windows-WinLogon, события с кодом 7001 и 7002
# Параметр - $Days, указывает за сколько последних дней выдать результат.

#!!!Для удаленного выполнения, необходимо запустить от имени локального админа!!!

function Get-LogonHistory{
Param(
[Parameter(Mandatory=$True)]
 [string]$Computer,
 [Parameter(Mandatory=$True)]
 [int]$Days
 )
 cls
 $Result = @()
 $starttime = (Get-Date).AddDays(-$Days)
 Write-Host "Gathering Event Logs, this can take awhile..."
 $ELogs = Get-EventLog System -Source Microsoft-Windows-WinLogon -After $starttime -ComputerName $Computer
 If ($ELogs)
 { Write-Host "Processing..."
 ForEach ($Log in $ELogs)
 { If ($Log.InstanceId -eq 7001)
   { $ET = "Logon"
   }
   ElseIf ($Log.InstanceId -eq 7002)
   { $ET = "Logoff"
   }
   Else
   { Continue
   }
   $Result += New-Object PSObject -Property @{
    ID = $Log.Index
    Time = $Log.TimeWritten
    'Event Type' = $ET
    User = (New-Object System.Security.Principal.SecurityIdentifier $Log.ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])
   }
 }
 $Result | Select ID, Time,"Event Type",User | Sort Time -Descending | Out-GridView
 Write-Host "Done."
 }
 Else
 { Write-Host "Problem with $Computer."
 Write-Host "If you see a 'Network Path not found' error, try starting the Remote Registry service on that computer."
 Write-Host "Or there are no logon/logoff events (XP requires auditing be turned on)"
 }
}


Get-LogonHistory