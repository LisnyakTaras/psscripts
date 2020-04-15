#Данный скрипт выводит членов локальной группы, количество пользователей группы

#!!!Для удаленного выполнения, необходимо запустить от имени локального админа!!!


Write-Host "Computer: $ComputerName"
$computer = [ADSI]"WinNT://$ComputerName" 
$objCount = ($computer.psbase.children| measure-object).count
Write-Host "Q-ty objects for computer '$ComputerName' = $objCount"
$Counter = 1
$result = @()
foreach($adsiObj in $computer.psbase.children)
{
  switch -regex($adsiObj.psbase.SchemaClassName)
    {
      "group"
      {
        $group = $adsiObj.name
        $LocalGroup = [ADSI]"WinNT://$ComputerName/$group,group"
        $Members = @($LocalGroup.psbase.Invoke("Members"))
        $objCount = ($Members | measure-object).count
        Write-Host "Q-ty objects for group '$group' = $objCount"
        $GName = $group.tostring()

        ForEach ($Member In $Members) {
          $Name = $Member.GetType().InvokeMember("Name", "GetProperty", $Null, $Member, $Null)
          $Path = $Member.GetType().InvokeMember("ADsPath", "GetProperty", $Null, $Member, $Null)
          Write-Host " Object = $Path"

                   $isGroup = ($Member.GetType().InvokeMember("Class", "GetProperty", $Null, $Member, $Null) -eq "group")
          If (($Path -like "*/$strComputer/*") -Or ($Path -like "WinNT://NT*")) { $Type = "Local"
          } Else {$Type = "Domain"}
          $result += New-Object PSObject -Property @{
            Computername = $ComputerName
            NameMember = $Name
            PathMember = $Path
            TypeMemeber = $Type
            ParentGroup = $GName
            Depth = $Counter
          }
        }
      }
    } #end switch
} #end foreach
Write-Host "Total objects = " ($result | measure-object).count
$result = $result | select-object Computername, ParentGroup, NameMember, TypeMemeber, Depth
$result |  Out-GridView  # Export-Csv -path ("F:\LocalGroups({0})-{1:yyyyMMddHHmm}.csv" -f
#$env:COMPUTERNAME,(Get-Date)) -Delimiter ";" -Encoding "UTF8" -force -NoTypeInformation