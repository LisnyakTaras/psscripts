
$comps = Get-ADComputer -Filter {Enabled -eq "True"} -SearchBase "OU=РЦ21,OU=Компьютеры,DC=atbmarket,DC=com"


$comps | Select-Object Name | Export-Csv -path ("F:\RC-21_Comp.csv")  -Append -Force