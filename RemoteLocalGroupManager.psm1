<#
    Module: RemoteLocalGroupManager
    Author: Dark-Coffee
    Version: 1.0
    Updated: 2020-10-14
    Description: Functions to extend the LocalAccounts module to remote machines.
    Changelog: 
#>

#Requires -Version 5.0


#---------------------------------------------------------------------------------------#
#---------------------------------------------------------------------------------------#


#Group Functions


function Get-RemoteLocalGroup {
    param (
        [Parameter(Mandatory=$True)][string]$ComputerName,
        [Parameter(Mandatory=$false)][SecureString]$Credential
    )

    $RemoteLocalGroupCollection = (invoke-command -ComputerName $ComputerName -ScriptBlock {Get-LocalGroup | Select Name,Description})

    Write-Host "Groups from $ComputerName :"
    $RemoteLocalGroupCollection | Sort-Object Name | Format-Table
}


#---------------------------------------------------------------------------------------#


#User Functions


function Add-RemoteLocalGroupMember {
    param (
        [Parameter(Mandatory=$True)][string]$ComputerName,
        [Parameter(Mandatory=$True)][string]$Group,
        [Parameter(Mandatory=$True)][string]$Member,
        [Parameter(Mandatory=$false)][SecureString]$Credential
    )

    invoke-command -ComputerName $ComputerName -ScriptBlock {Add-LocalGroupMember -Group $Using:Group -Member $Using:Member -Confirm}
}


function Get-RemoteLocalGroupMember {
    param (
        [Parameter(Mandatory=$True)][string]$ComputerName,
        [Parameter(Mandatory=$True)][string]$Group,
        [Parameter(Mandatory=$false)][SecureString]$Credential
    )

    $RemoteLocalGroupMemberCollection = (invoke-command -ComputerName $ComputerName -ScriptBlock {Get-LocalGroupMember -Group $Using:Group})

    Write-Host "Members from $Group on $ComputerName :"
    $RemoteLocalGroupMemberCollection | Select-Object ObjectClass,Name,PrincipalSource -ExcludeProperty PSComputerName,SID,RunspaceID | Sort-Object ObjectClass,Name | Write-Output
}


function Remove-RemoteLocalGroupMember {
    param (
        [Parameter(Mandatory=$True)][string]$ComputerName,
        [Parameter(Mandatory=$True)][string]$Group,
        [Parameter(Mandatory=$True)][string]$Member,
        [Parameter(Mandatory=$false)][SecureString]$Credential
    )

    invoke-command -ComputerName $ComputerName -ScriptBlock {Remove-LocalGroupMember -Group $Using:Group -Member $Using:Member -Confirm}
}


#---------------------------------------------------------------------------------------#


#Export Member Functions


Export-ModuleMember -Function Get-RemoteLocalGroup
Export-ModuleMember -Function Add-RemoteLocalGroupMember
Export-ModuleMember -Function Get-RemoteLocalGroupMember
Export-ModuleMember -Function Remove-RemoteLocalGroupMember


#---------------------------------------------------------------------------------------#
#---------------------------------------------------------------------------------------#