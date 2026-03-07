@description('Name of the resource group')
param resourceGroupName string

@description('Azure region for the resource group')
param location string

@description('Tags for the resource group')
param tags object = {}

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

output name string = rg.name
output id string = rg.id
