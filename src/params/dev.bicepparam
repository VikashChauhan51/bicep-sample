using '../main.bicep'

param resourceGroupName = 'rg-bicep-sample-dev'

param location = 'eastus'

param tags = {
  environment: 'dev'
  owner: 'vikash'
}
