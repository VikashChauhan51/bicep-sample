using '../main.bicep'

var addressSpace = [
  '10.0.0.0/16'
  '192.168.0.0/16'
]
param resourceGroupName = 'rg-bicep-sample-dev'
param location = 'eastus'
param vnetConfig = {
  vnetName: 'vnet-sample-dev'
  location: location
  addressSpace:addressSpace
tags: tags
}

param subnetConfig = {
  vnetName: 'vnet-sample-dev'
  subnetName: 'subnet-sample-dev'
  addressPrefix: '10.0.0.0/24'
} 

param storageAccountName = 'devstoragesample123'
param storageSku = 'Premium_LRS'
param tags = {
  environment: 'dev'
  owner: 'vikash'
}
