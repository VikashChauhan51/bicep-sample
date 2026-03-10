
import {VNetConfig} from 'vnet.types.bicep'

@description('Configuration to create a virtual network')
param vnetConfig  VNetConfig

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetConfig.vnetName
  location: vnetConfig.location
  tags: vnetConfig.tags
  properties: {
    addressSpace: {
      addressPrefixes: vnetConfig.addressSpace
    }
  }
}

output name string = vnet.name
output id string = vnet.id
output location string = vnet.location
output addressSpace array = vnet.properties.addressSpace.addressPrefixes
