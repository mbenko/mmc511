

az login
az account set --s fy22-mvp-imademo

$appName = "mmc511"
$env = "bicep"
$rg = "bnk-$env-$appName-rg"
$today = Get-Date -Format 'MMddyy-hhmm'
$deploymentName = "testArm-$today"
$templateFile = ".\mySite.json"
$paramFile = ".\mySite.parameters.json"

