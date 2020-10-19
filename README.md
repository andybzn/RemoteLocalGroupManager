# RemoteLocalGroupManager
what it says on the tin?

## Install
```
$PSModDir="$($env:PSModulePath|%{$_ -replace ";.*"})\GetDirectory\";if(!(Test-Path($PSModDir))){New-Item -Type Directory $PSModDir};Start-BitsTransfer 'https://raw.githubusercontent.com/dark-coffee/Get-Directory/master/GetDirectory.psm1' "$PSModDir\GetDirectory.psm1";Import-Module GetDirectory;
```
