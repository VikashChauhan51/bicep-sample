targetScope = 'subscription'

import {VNetConfig} from './modules/network/vnet/vnet.types.bicep'
import {SubnetConfig} from './modules/network/subnet/subnet.types.bicep'

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

@description('Name of the storage account')
param storageAccountName string

@description('SKU for the storage account')
@allowed(['Standard_LRS', 'Premium_LRS', 'Standard_ZRS', 'Premium_ZRS'])
param storageSku string = 'Standard_LRS'


@description('Configuration to create a virtual network')
param vnetConfig  VNetConfig
@description('Configurations to create a subnet in a virtual network')
param subnetConfig SubnetConfig


// Resource Group
module rg './modules/platform/resource-group.bicep' = {
  name: 'resourceGroupDeployment'
  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}

// VNet
module vnet './modules/network/vnet/vnet.bicep' = {
  name: 'vnetDeployment'
  scope: resourceGroup(resourceGroupName)
  params: {
    vnetConfig: vnetConfig
  }
}

// Subnets
module subnetApp './modules/network/subnet/subnet.bicep' = {
  name: 'subnetAppDeployment'
  scope: resourceGroup(resourceGroupName)
  params: {
   subnetConfig: subnetConfig
  }
}

module subnetDb './modules/network/subnet/subnet.bicep' = {
  name: 'subnetDbDeployment'
  scope: resourceGroup(resourceGroupName)

  params: {
    subnetConfig:{
      vnetName: subnetConfig.vnetName
    subnetName: 'db-subnet'
    addressPrefix: subnetConfig.addressPrefix
    }
  }
}

// Storage Account
module storage './modules/data/storage-account.bicep' = {
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
