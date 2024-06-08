@description('The location in which all resources should be deployed.')
param location string = resourceGroup().location

@description('provide a 2-13 character prefix for all resources.')
param ResourcePrefix string

@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string

@description('The administrator login password for the SQL server.')

param sqlServerAdministratorLoginPassword string

@description('The name and tier of the SQL database SKU.')
param sqlDatabaseSku object = {
  name: 'Standard'
  tier: 'Standard'
}

var sqlServerName = 'sql${ResourcePrefix}'
var sqlDatabaseName = 'genaicxfoundryDb'

resource sqlServer 'Microsoft.Sql/servers@2021-11-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}

resource sqlFirewallRule 'Microsoft.Sql/servers/firewallRules@2022-05-01-preview' = {
  name: '${sqlServerName}/AllowAllAzureServices'
  location: location
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
  dependsOn: [
    sqlServer
  ]
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-11-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: sqlDatabaseSku
}
