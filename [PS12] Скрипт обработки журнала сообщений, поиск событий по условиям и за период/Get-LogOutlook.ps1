#Выводим события связаные с Outlook, за $Days-дней до сегодняшнего числа.

#!!!Для удаленного выполнения, необходимо запустить от имени локального админа!!!

Param(
[Parameter(Mandatory=$True)]
 [string]$Computer,
 [Parameter(Mandatory=$True)]
 [int]$Days
 )


$starttime = (Get-Date).AddDays(-$Days)  
Get-WinEvent -ComputerName $Computer -FilterHashtable @{logname="application"; ProviderName="outlook"; StartTime= $starttime} | fl

