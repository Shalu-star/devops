targetScope='subscription'

@description('provide a 2-13 character prefix for all resources.')
param ResourcePrefix string

param resourceGroupName string = 'rgs-${ResourcePrefix}'
param location string 

resource newRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: location
}
