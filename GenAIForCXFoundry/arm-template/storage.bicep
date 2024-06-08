@description('provide a 2-13 character prefix for all resources.')
param ResourcePrefix string

@description('Name of Storage Account')
param StorageAccountName string = '${ResourcePrefix}str'

@description('The location in which all resources should be deployed.')
param location string = resourceGroup().location

var BlobContainerName = 'images'

resource StorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: StorageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_GRS'
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

resource StorageAccountName_default_BlobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: '${StorageAccountName}/default/${BlobContainerName}'
  properties: {
    publicAccess: 'None'
  }
  dependsOn: [
    StorageAccount
  ]
}





