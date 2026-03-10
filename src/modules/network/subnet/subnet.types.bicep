@export()
type SubnetConfig = {

  @description('Name of the virtual network')
  vnetName: string

  @description('Name of the subnet')
  subnetName: string

  @description('Address prefix for the subnet')
  addressPrefix: string
}
