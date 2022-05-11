@description('description')
param appName string

@description('description')
param env string

var siteName_var = 'arm-${appName}${env}-site'
var hostName_var = 'arm-${appName}${env}-host'

resource hostName 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: hostName_var
  location: resourceGroup().location
  sku: {
    name: 'F1'
    capacity: 1
  }
  tags: {
    displayName: hostName_var
  }
  properties: {
    name: hostName_var
  }
}

resource siteName 'Microsoft.Web/sites@2020-12-01' = {
  name: siteName_var
  location: resourceGroup().location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms${hostName_var}': 'Resource'
    displayName: siteName_var
  }
  properties: {
    name: siteName_var
    serverFarmId: hostName.id
  }
}

output siteName string = siteName_var
output rgName string = resourceGroup().name