az login

az account set --s fy22-mvp-imademo
az account show

$appName = "mmc511"
$env = "arm"
$rg = "bnk-$env-$appName-rg"
$today = Get-Date -Format 'MMddyy-hhmm'
$deploymentName = "testArm-$today"
$templateFile = ".\mySite.json"
$paramFile = ".\mySite.parameters.json"

## Deploy RG and ARM template
az group create --name $rg --location centralus
az deployment group create --name $deploymentName --resource-group $rg --template-file $templateFile --parameters $paramFile

$outputs = $(az group deployment show --n $deploymentName --r $rg --q properties.outputs) | ConvertFrom-Json
$arm_site_name = $outputs.siteName.Value
$arm_rg_name = $outputs.rgName.value

