@export()
type VNetConfig = {

  @description('Create a virtual network')
  vnetName: string

  @description('Location for the resource group')
  location: string

  @description('Address space for the virtual network')
  addressSpace: array

  @description('Tags for the resource group')
  tags: object
}
