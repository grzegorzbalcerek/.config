# copy Microsoft.PowerShell_profile.ps1 $PROFILE
# copy $HOME\.config\ps\Microsoft.PowerShell_profile.ps1 $PROFILE

function cdd {Set-Location -Path $HOME\doc}
function cdD {Set-Location -Path $HOME\Downloads}
function cdde {Set-Location -Path $HOME\doc\emacs}
function cddr {Set-Location -Path $HOME\doc\rbs}
function cddrc {Set-Location -Path $HOME\doc\rbs\cov26}
function cdg {Set-Location -Path $HOME\gh}
function cdh {Set-Location -Path $HOME}
function cdl {Set-Location -Path $HOME\lib}
function cdr {Set-Location -Path $HOME\rep}
function cdrr {Set-Location -Path $HOME\rep\rbs}
function cdrra {Set-Location -Path $HOME\rep\rbs\app}
function cdrro {Set-Location -Path $HOME\rep\rbs\ognt}

Set-Alias -name g -value git

