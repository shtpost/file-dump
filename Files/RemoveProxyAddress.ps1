Get-WindowsCapability -Name RSAT.ActiveDirectory* -Online | Add-WindowsCapability -Online
Import-Module ActiveDirectory

import-csv C:\Users\User\Documents\BCIS_Users.csv |

ForEach-Object {
    $users = Get-ADUser -Filter "ObjectGUID -eq '$($_.objectGUID)'" -Properties proxyAddresses -WhatIf
    foreach($User in $Users){
        Write-host $user
        Foreach($proxyaddress in $user.proxyaddresses){
            If ($proxyaddress -like "*bcis.co.uk"){
                write-host $proxyaddress
                Set-ADUser -Identity $user.distinguishedName -remove @{proxyaddresses = $proxyaddress} -WhatIf
            }
        }
    }
}