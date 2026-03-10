test vnetDefault '../../../src/modules/network/vnet/vnet.bicep' = {
  params: {
    vnetConfig: {
      vnetName: 'vnet-sample-dev'
      location: 'eastus'
      addressSpace: [
        '10.0.0.0/16'
        '192.168.0.0/16'
      ]
      tags: {
        environment: 'dev'
        owner: 'vikash'
      }
    }
  }
}
