# Скрипт ищет в Event Logs раздел-System, группа-Microsoft-Windows-WinLogon, события с кодом 7001 и 7002
# Параметр - $Days, указывает за сколько последних дней выдать результат.

#!!!Для удаленного выполнения, необходимо запустить от имени локального админа!!!

function Get-PowerOnHistory{
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
 $ELogs = Get-EventLog System -Source EventLog -After $starttime -ComputerName $Computer
 If ($ELogs)
 { Write-Host "Processing..."
 ForEach ($Log in $ELogs)
 { If ($Log.EventId -eq 6005)
   { $ET = "Комп запустился"
   }
   ElseIf ($Log.EventId -eq 6006)
   { $ET = "Комп выключили"
   }
   ElseIf ($Log.EventId -eq 6008)
   { $ET = "Комп включился полсе аварийного выключения"
   }
   Else
   { Continue
   }
   $Result += New-Object PSObject -Property @{
    ID = $Log.Index
    Time = $Log.TimeWritten
    'Event Type' = $ET
     Message = $Log.Message
   }
 }
 $Result | Select ID, Time,"Event Type",Message  | Sort Time -Descending | Out-GridView
 Write-Host "Done."
 }
 Else
 { Write-Host "Problem with $Computer."
 Write-Host "If you see a 'Network Path not found' error, try starting the Remote Registry service on that computer."
 Write-Host "Or there are no logon/logoff events (XP requires auditing be turned on)"
 }
}


Get-PowerOnHistory

#https://serverfault.com/questions/702828/windows-server-restart-shutdown-history


<#Очень интересное решение данной проблемы, при чем можно добавить фильтр по разным категориям.

$xml=@'
<QueryList>
<Query Id="0">
<Select Path="System">*[System[(EventID=6005)]]</Select>
<Select Path="System">*[System[(EventID=6006)]]</Select>
<Select Path="Application">*[System[(EventID=1704)]]</Select> # Здесь добавил из другой группы событие.
</Query>
</QueryList>
'@
 
Get-WinEvent -FilterXml $xml -MaxEvents 10 | Out-GridView


#Get-WinEvent -FilterXml $xml -MaxEvents 5 -ComputerName Server01,Server02 можно даже так.
#>