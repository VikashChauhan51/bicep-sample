
@description('Name of the storage account')
param storageAccountName string
@description('Azure region for the resource group')
param location string
@description('Tags for the resource group')
param tags object = {}
@description('SKU for the storage account')
@allowed(['Standard_LRS', 'Premium_LRS', 'Standard_ZRS', 'Premium_ZRS'])
param sku string = 'Standard_LRS'


resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: sku
  }
  kind: 'StorageV2'

  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
  }
}

output storageAccountId string = storage.id
output storageAccountName string = storage.name
output storageAccountLocation string = storage.location
output storageAccountTags object = storage.tags
output storageAccountAccessTier string = storage.properties.accessTier
output storageAccountAllowBlobPublicAccess bool = storage.properties.allowBlobPublicAccess
output storageAccountMinimumTlsVersion string = storage.properties.minimumTlsVersion
