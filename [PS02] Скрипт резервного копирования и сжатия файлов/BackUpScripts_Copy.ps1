
$fileCount = ( Get-ChildItem C:\BackUpScripts | Measure-Object ).Count;
 Write-Host $fileCount

Compress-Archive -Path C:\Scripts\* -CompressionLevel Optimal -DestinationPath C:\Scripts\ArchiveScripts$(get-date -f yyyy-MM-dd-mm-ss)

if($fileCount -eq 5)
    {
        Get-ChildItem C:\BackUpScripts|Get-ChildItem | Sort-Object -Property LastWriteTime | Select-Object -Index 0 | Remove-Item
        Copy-Item C:\Scripts\*.zip C:\BackUpScripts
    }

elseif($fileCount -ne 5)
    {
    Copy-Item -Path C:\Scripts\*.zip -Destination C:\BackUpScripts\
    }

        Remove-Item -Path C:\Scripts\*.zip

    