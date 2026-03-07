@description('Create a virtual network')
param vnetName string
@description('Azure region for the resource group')
param location string
@description('Address space for the virtual network')
param addressSpace array
@description('Tags for the resource group')
param tags object = {}

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressSpace
    }
  }
}

output name string = vnet.name
output id string = vnet.id
output location string = vnet.location
output addressSpace array = vnet.properties.addressSpace.addressPrefixes
