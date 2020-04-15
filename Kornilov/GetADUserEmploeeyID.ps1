$result=Get-ADUser -Properties EmployeeID -Filter {EmployeeID -like "ПРЛ-*" -and Enabled -eq "True"} -SearchBase "OU=WMS РЦ - 6, DC=atbmarket, DC=com"   

$result = $result | select-object SamAccountName,EmployeeID  
$result | foreach-object {$_.EmployeeID -replace "ПРЛ", "PRL"}  | Set-Content -path F:\test.txt


$EmployeeID = Get-Content -path F:\test.txt
$objCount = ($result.SamAccountName | measure-object).count
$i=0

foreach($adsiObj in $result.SamAccountName){

    if($result.SamAccountName -match $EmployeeID[$i])
        {   
       
            $i++
        }
        else{
       $adsiObj 
        
        $i++}
          
  }
 
