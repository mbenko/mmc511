param appName string
param env string

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'bnk-${env}-${appName}-rg'
  location: 'centralus'
}
