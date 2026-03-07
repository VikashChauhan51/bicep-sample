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

@description('Name of the virtual network')
param vnetName string

@description('Address space for the virtual network')
param addressSpace array = ['10.0.0.0/16']

@description('Name of the subnet')
param subnetName string

@description('Address prefix for the subnet')
param subnetAddressPrefix string = '10.0.0.0/24'

@description('Name of the storage account')
param storageAccountName string

@description('SKU for the storage account')
@allowed(['Standard_LRS', 'Premium_LRS', 'Standard_ZRS', 'Premium_ZRS'])
param storageSku string = 'Standard_LRS'




// Resource Group
module rg './modules/resource-group.bicep' = {
  name: 'resourceGroupDeployment'
  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}

// VNet
module vnet './modules/vnet.bicep' = {
  name: 'vnetDeployment'
  scope: resourceGroup(resourceGroupName)
  params: {
    vnetName: vnetName
    location: location
    addressSpace: addressSpace
    tags: tags
  }
}

// Subnets
module subnetApp './modules/subnet.bicep' = {
  name: 'subnetAppDeployment'
  scope: resourceGroup(resourceGroupName)

  params: {
    vnetName: vnetName
    subnetName: subnetName
    addressPrefix: subnetAddressPrefix
  }
}

module subnetDb './modules/subnet.bicep' = {
  name: 'subnetDbDeployment'
  scope: resourceGroup(resourceGroupName)

  params: {
    vnetName: vnetName
    subnetName: 'db-subnet'
    addressPrefix: subnetAddressPrefix
  }
}

// Storage Account
module storage './modules/storage-account.bicep' = {
  name: 'storageDeployment'
  scope: resourceGroup(resourceGroupName)

  params: {
    storageAccountName: storageAccountName
    location: location
    tags: tags
    sku: storageSku
  }
}

// Output
// Resource Group
output resourceGroupId string = rg.outputs.id
output resourceGroupName string = rg.outputs.name

// Virtual Network
output vnetId string = vnet.outputs.id
output vnetName string = vnet.outputs.name

// Subnets
output appSubnetId string = subnetApp.outputs.subnetId
output dbSubnetId string = subnetDb.outputs.subnetId

// Storage Account
output storageAccountId string = storage.outputs.storageAccountId
output storageAccountName string = storageAccountName
