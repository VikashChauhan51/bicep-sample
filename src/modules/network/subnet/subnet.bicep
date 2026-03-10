import {SubnetConfig} from 'subnet.types.bicep'

@description('Configurations to create a subnet in a virtual network')
param subnetConfig SubnetConfig

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: '${subnetConfig.vnetName}/${subnetConfig.subnetName}'
  properties: {
    addressPrefix: subnetConfig.addressPrefix
  }
}

output subnetId string = subnet.id
output subnetName string = subnet.name
output subnetAddressPrefix string = subnet.properties.addressPrefix
