# Скрипт ищет в Event Logs раздел-Security, группа-Microsoft-Windows-security-auditing, события с кодом 4732 и 4733

#!!!Для удаленного выполнения, необходимо запустить от имени локального админа!!!

function get-ChangeLocalGroups{
Param (
 [string]$Computer = (Read-Host Remote computer name)
 )
 cls
 $Result = @()
 Write-Host "Gathering Event Logs, this can take awhile..."
 $ELogs = Get-EventLog Security -Source Microsoft-Windows-security-auditing -ComputerName $Computer
 If ($ELogs)
    { 
        Write-Host "Processing..."
        ForEach ($Log in $ELogs)

            { If ($Log.InstanceId -eq 4732)
               {
                 $ET = "Was Added"
               }
               ElseIf ($Log.InstanceId -eq 4733)
               { 
                $ET = "Was Removed"
               }
               Else
               { Continue
               }
   $Result += New-Object PSObject -Property @{
    ID = $Log.Index
    Time = $Log.TimeWritten
    'Event Type' = $ET
    User = (New-Object System.Security.Principal.SecurityIdentifier $Log.ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])
# $Log.ReplacementStrings - хранит в себе масив из четырех елементов, второй из них SID пользователя
# с помощью Translate([System.Security.Principal.NTAccount]) - переводим СИД в удобочитаймый вид!!!
    Group = $Log.ReplacementStrings[2] 
    
   }
 }
 $Result | Select ID, Time,"Event Type",User, Group | Sort Time -Descending | Out-GridView


 Write-Host "Done."
 }

 Else
     { Write-Host "Problem with $Computer."
     Write-Host "If you see a 'Network Path not found' error, try starting the Remote Registry service on that computer."
     Write-Host "Or there are no logon/logoff events (XP requires auditing be turned on)"
     }
}


get-logonhistory -Computer "market-070-145"






