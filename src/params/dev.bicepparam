using '../main.bicep'

param resourceGroupName = 'rg-bicep-sample-dev'

param location = 'eastus'
param vnetName = 'vnet-sample-dev'
param storageAccountName = 'devstoragesample123'
param subnetName = 'subnet-sample-dev'
param addressSpace = [
  '10.0.0.0/16'
  '192.168.0.0/16'
]
param storageSku = 'Premium_LRS'
param tags = {
  environment: 'dev'
  owner: 'vikash'
}
