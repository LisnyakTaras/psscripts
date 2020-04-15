#1) Вывод членства в группах юзера в Excel-файл
Get-ADPrincipalGroupMembership lisnyakt | select name | Export-csv "C:\Scripts\Членство в группах.csv" -Encoding UTF8

#2)Вывод вложенных групп ( Очень часто группа входит в какую-либо группу)  глубина - 10 групп
Get-ADPrincipalGroupMembership "Администраторы ОТП" | select name

#3)сделать скрипт проверки - входит ли пользователь в конкретную группу АД - результат показать на прямом вхождении и на косвенном вхождении

Param (
#[parameter(Mandatory=$true)] 
#[string]$group,
[parameter(Mandatory=$true)]
[string]$user
)
$group = "Администраторы ОТП"
$members = Get-ADGroupMember -Identity $group -Recursive | Select -ExpandProperty SamAccountName

If ($members -contains $user) {
      Write-Host "$user exists in the group"
 }
  Else {
        Write-Host "$user not exists in the group"
        }