$RootHotfixPath = 'C:\Hotfix\'
 
$Hotfixes = @(
        'windows10.0-kb4525236-x64.msu'
)
$Servers = Get-Content 'C:\Hotfix\MachineList.txt'

foreach ($Server in $Servers)
{
    Write-Host "Processing $Server..."

    $needsReboot = $False
    $remotePath = "\\$Server\C$\Windows\Temp\"

    if(Test-Connection $Server -Count 1 -Quiet) 
    {
        Write-Warning "$Server is not accessible"
        continue
    }

    if ( -not (Test-Path $remotePath))
    {
        Write-Host "Folder C:\Temp does not exist on the target server"
        # Maybe create it now? 
        continue
    }

    foreach ($Hotfix in $Hotfixes)
    {
        Write-Host "`thotfix: $Hotfix"
        $HotfixPath = "$RootHotfixPath$Hotfix"

        Copy-Item $Hotfixpath $remotePath
        # Run command as SYSTEM via PsExec (-s switch)
        & C:\Windows\PsExec -s \\$Server wusa C:\Temp\$Hotfix /quiet /norestart
        write-host "& C:\Windows\PsExec -s \\$Server wusa C:\Temp\$Hotfix /quiet /norestart"
        if ($LastExitCode -eq 3010) {
            $needsReboot = $true
        }
    }

    # Delete local copy of update packages
    Remove-Item (Join-Path $remotePath '*.msu')

    if($needsReboot)
    {
        Write-Host "Restarting $Server..."
        Restart-Computer -ComputerName $Server -Force
    }
}