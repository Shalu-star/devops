@description('The location in which all resources should be deployed.')
param location string = resourceGroup().location

@description('provide a 2-13 character prefix for all resources.')
param ResourcePrefix string

@description('Web app name.')
param appName string = '${ResourcePrefix}-frontend-website'

@description('The pricing tier for the App Service plan')
@allowed([
  'F1'
  'D1'
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1'
  'P2'
  'P3'
  'P4'
])
param HostingPlanSku string = 'B1'

@secure()
param docker_password string

@description('Frontend Web app name.')
param backendAppName string = '${ResourcePrefix}-backend-website'

var BackendWebsiteUrl = 'https://${backendAppName}.azurewebsites.net'

var NEXT_PUBLIC_API_URL = BackendWebsiteUrl


var FrontendImageName =  'DOCKER|dcxgenai.azurecr.io/dcxgenai/dcx-genai-dev-studion-image:5fa45a9cf6b2c9a20b0b0e5dd01fc3f86c860793'
var appServicePlanName = 'ASP-${appName}'
var appServiceAppName = '${ResourcePrefix}-frontend-website'


resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: HostingPlanSku
  }
  properties: {
    reserved: true
  }
  kind: 'linux'
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
        siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://dcxgenai.azurecr.io' // Replace 'youracrname' with your ACR login server name
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: 'dcxgenai'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: docker_password
        }
        {
          name:'NEXT_PUBLIC_API_URL'
          value:NEXT_PUBLIC_API_URL
        }
      ]
      use32BitWorkerProcess: false
      linuxFxVersion: FrontendImageName
      appCommandLine: ''
      alwaysOn: true
    }
    
  }
  dependsOn:[appServicePlan]
  
}


