
function Install-Config-Powershell { copy $env:HOME\.config\powershell\Microsoft.PowerShell_profile.ps1 $PROFILE }
function Install-Config-Emacs { copy $env:HOME\.config\emacs\.emacs $env:Home\.emacs }

function cdc {cd $env:HOME\.config}
function cdd {cd $env:HOME\doc}
function cdde {cd $env:HOME\doc\emacs}
function cddr {cd $env:HOME\doc\rbs}
function cddrc {cd $env:HOME\doc\rbs\cov26}
function cddro {cd $env:HOME\doc\rbs\ognt}
function cdg {cd $env:HOME\gh}
function cdh {cd $env:HOME}
function cdl {cd $env:HOME\lib}
function cdm {cd $env:HOME\mama}
function cdo {cd $env:HOME\Downloads}
function cdr {cd $env:HOME\rep}
function cdrr {cd $env:HOME\rep\rbs}
function cdrra {cd $env:HOME\rep\rbs\app}
function cdrro {cd $env:HOME\rep\rbs\ognt}
function cdrz {cd $env:HOME\rep\zk}
function cdrzz {cd $env:HOME\rep\zk\zkvault}

function gh {cat $env:HOME\doc\cards\github.com.md}

function e {emacs -nw}
function n {nvim}
function t {param($title); $host.ui.RawUI.WindowTitle = $title }
function twd {$host.ui.RawUI.WindowTitle = (Split-Path (pwd) -Leaf) }
function v {vim}

sal g git
sal n nvim
sal v vim
