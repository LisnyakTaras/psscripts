$Servers=  'MARKET-072-213' #Get-Content 'C:\temp\ServerNames.txt'
$ScriptBlock = {
    $Groups = Get-WmiObject Win32_GroupUser -ComputerName $Using:ServerName
    $LocalAdmins = $Groups | Where GroupComponent –like '*"Administrators"'
    $LocalAdmins | ForEach-Object {  
        If($_.partcomponent –match ".+Domain\=(.+)\,Name\=(.+)$"){  
            $matches[1].trim('"') + "\" + $matches[2].trim('"')
        }
    }
}
ForEach ($ServerName in $Servers) {
    "Local Admin group members in $ServerName" #| Out-File $Output -Append
    Invoke-command -ScriptBlock $ScriptBlock -ComputerName $ServerName | Write-Host
}