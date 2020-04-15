
$users = Get-Content "C:\Users\Public\Documents\DataForScripts\users.txt"

foreach($us in $users){
    $us = $us.Replace(" ","")
    $temp = get-aduser $us -properties HomePage

    Write-Output  ($temp.SamAccountName +" - "+ $temp.HomePage)
}


