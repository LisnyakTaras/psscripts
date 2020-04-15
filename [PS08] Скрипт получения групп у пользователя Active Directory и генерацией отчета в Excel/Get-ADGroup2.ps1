#requires -version 4
<#
.SYNOPSIS
    List all upstream nested memberof groups recursively of a Active Directory user.
.DESCRIPTION
    The Get-ADGroupsUpStream list all nested group list of a AD user. It requires only valid parameter AD username, 
.PARAMETER UserName
    Prompts you valid active directory User name. You can use first character as an alias, If information is not provided it provides 'Administrator' user information. 'Name' can be used as an alias
.INPUTS
    Microsoft.ActiveDirectory.Management.ADUser
.OUTPUTS
    Microsoft.ActiveDirectory.Management.ADGroup
.NOTES
    Version:        1.0
    Author:         Kunal Udapi
    Creation Date:  10 September 2017
    Purpose/Change: Get the exact nested group info of user
    Useful URLs: http://vcloud-lab.com
.EXAMPLE
    PS C:\>.\Get-ADGroupsUpStream -UserName Administrator

    This list all the upstream group an user a member of.
#>
function Get-ADGroupsUpStream{
[CmdletBinding(SupportsShouldProcess=$True,
    ConfirmImpact='Medium',
    HelpURI='http://vcloud-lab.com',
    DefaultParameterSetName='Manual')]
Param
(
    [parameter(Position=0, <#Mandatory=$True,#> ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true, HelpMessage='Type valid AD username')]
    [alias('Name')]
$UserName = 'Administrator'
)
begin {
    if (!(Get-Module Activedirectory)) {
        try {
            Import-Module ActiveDirectory -ErrorAction Stop 
        }
        catch {
            Write-Host -Object "ActiveDirectory Module didn't find, Please install it and try again" -BackgroundColor DarkRed
            Break
        }
    }
}
process {
    #$UserName = 'User1'
    try {
        $MemberInfo = Get-ADUser $UserName –Properties MemberOf -ErrorAction Stop
    }
    catch {
        Write-Host -Object "`'$username`' doesn't exist in Active Directory, try again with valid user" -BackgroundColor DarkRed
        break
    }
    $MemberOf = $MemberInfo | Select-Object -ExpandProperty MemberOf 
    foreach ($Group in $MemberOf) {
        $CompleteInfo = @()
        $GroupInfo = Get-ADGroup $Group –Properties MemberOf
        $CompleteInfo += $MemberInfo.Name
        $CompleteInfo += $GroupInfo.Name
        $UpperGroup = $GroupInfo | Select-Object -ExpandProperty MemberOf
        #$GroupInfo.Name #test
        do 
        {
            foreach ($x in $UpperGroup) {
                $UpperGroupInfo = Get-AdGroup $x -Properties Memberof
                $CompleteInfo += $UpperGroupInfo.Name
                $UpperGroup =  $UpperGroupInfo | Select-Object -ExpandProperty Memberof
                #$UpperGroupInfo.Name #test
                #$UpperGroup
            }
        }
        while ($UpperGroup -ne $null)
        $CompleteInfo -Join " << "
        #[array]::Reverse($CompleteInfo)
        #$CompleteInfo -join '\'
    }
}
end {}
}
Get-ADGroupsUpStream -UserName kornilov
