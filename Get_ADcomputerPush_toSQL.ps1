#Install-Module -Name SqlServer
$adcomps = Get-ADComputer -Filter {OperatingSystem -like "*windows 10*"} -Properties CanonicalName | select Name, CanonicalName
$ResUserPlace=@()


$User = "sa"
$PWord = ConvertTo-SecureString -String "Djhrths@0!3" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord


$ID = 1
ForEach($adcomp in $adcomps)
    {
     $adcomp.CanonicalName = $adcomp.CanonicalName -replace("atbmarket.com/Компьютеры/","")
     $adcomp.CanonicalName = $adcomp.CanonicalName -replace($adcomp.Name,"")

    $ResUserPlace += New-Object PSObject -Property @{
            ID = $ID
            CompName = $adcomp.Name
            Office = $adcomp.CanonicalName
    }
    $ID = $ID+1
 }

write-SqlTableData -credential $Credential -serverinstance 'otp-sql-test' -DatabaseName 'PackOTP' -SchemaName 'dbo' -TableName 'ADcompList' -InputData $ResUserPlace -Force
