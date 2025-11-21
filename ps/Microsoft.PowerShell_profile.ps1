# copy Microsoft.PowerShell_profile.ps1 $PROFILE
# copy $HOME\.config\ps\Microsoft.PowerShell_profile.ps1 $PROFILE

function cdc {Set-Location -Path $HOME\.config}
function cdd {Set-Location -Path $HOME\doc}
function cdde {Set-Location -Path $HOME\doc\emacs}
function cddr {Set-Location -Path $HOME\doc\rbs}
function cddrc {Set-Location -Path $HOME\doc\rbs\cov26}
function cddro {Set-Location -Path $HOME\doc\rbs\ognt}
function cdg {Set-Location -Path $HOME\gh}
function cdh {Set-Location -Path $HOME}
function cdl {Set-Location -Path $HOME\lib}
function cdm {Set-Location -Path $HOME\mama}
function cdo {Set-Location -Path $HOME\Downloads}
function cdr {Set-Location -Path $HOME\rep}
function cdrr {Set-Location -Path $HOME\rep\rbs}
function cdrra {Set-Location -Path $HOME\rep\rbs\app}
function cdrro {Set-Location -Path $HOME\rep\rbs\ognt}
function cdz {Set-Location -Path $HOME\zk}

Set-Alias -name g -value git

