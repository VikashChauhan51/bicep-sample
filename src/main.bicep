targetScope = 'subscription'

@description('The location where resources will be deployed.')
@allowed([
  'eastus'
  'westus'
  'centralus'
  'northcentralus'
  'southcentralus'
  'northeurope'
  'westeurope'
  'uksouth'
  'ukwest'
  'southeastasia'
  'eastasia'
])
param location string = 'eastus'

@description('The name of the resource group.')
param resourceGroupName string

@description('Tags for resources')
param tags object = {
  environment: 'dev'
  project: 'bicep-sample'
}

module resourceGroupModule './modules/resource-group.bicep' = {
  name: 'resourceGroupDeployment'
  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}

output resourceGroupId string = resourceGroupModule.outputs.id
