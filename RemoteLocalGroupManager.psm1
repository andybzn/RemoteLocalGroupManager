<#
    Module: RemoteLocalGroupManager
    Author: Dark-Coffee
    Version: 1.1
    Updated: 2020-10-16
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
        [Parameter(Mandatory=$false)][PSCredential]$Credential
    )

    if($Credential -ne $null){
        $RemoteLocalGroupCollection = (invoke-command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {Get-LocalGroup | Select Name,Description})
    }else{
        $RemoteLocalGroupCollection = (invoke-command -ComputerName $ComputerName -ScriptBlock {Get-LocalGroup | Select Name,Description})
    }

    Write-Output "Groups from $ComputerName :"
    $RemoteLocalGroupCollection | Sort-Object Name | Format-Table
    
}


#---------------------------------------------------------------------------------------#


#User Functions


function Add-RemoteLocalGroupMember {
    param (
        [Parameter(Mandatory=$True)][string]$ComputerName,
        [Parameter(Mandatory=$True)][string]$Group,
        [Parameter(Mandatory=$True)][string]$Member,
        [Parameter(Mandatory=$false)][PSCredential]$Credential
    )

    invoke-command -ComputerName $ComputerName -ScriptBlock {Add-LocalGroupMember -Group $Using:Group -Member $Using:Member -Confirm}
}


function Get-RemoteLocalGroupMember {
    param (
        [Parameter(Mandatory=$True)][string]$ComputerName,
        [Parameter(Mandatory=$True)][string]$Group,
        [Parameter(Mandatory=$false)][PSCredential]$Credential
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
        [Parameter(Mandatory=$false)][PSCredential]$Credential
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