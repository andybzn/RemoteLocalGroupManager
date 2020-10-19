# RemoteLocalGroupManager
what it says on the tin?

## Install
```
$PSModDir="$($env:PSModulePath|%{$_ -replace ";.*"})\RemoteLocalGroupManager\";if(!(Test-Path($PSModDir))){New-Item -Type Directory $PSModDir};Start-BitsTransfer 'https://raw.githubusercontent.com/dark-coffee/RemoteLocalGroupManager/master/GetDirectory.psm1' "$PSModDir\RemoteLocalGroupManager.psm1";Import-Module RemoteLocalGroupManager;
```
