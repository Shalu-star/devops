@description('The location in which all webapp resources should be deployed.')
param WebAppLocation string 

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

param docker_password string

@description('Frontend Web app name.')
param backendAppName string = '${ResourcePrefix}-backend-website'

var BackendWebsiteUrl = 'https://${backendAppName}.azurewebsites.net'

var NEXT_PUBLIC_API_URL = BackendWebsiteUrl

param pat string


var FrontendImageName =  'DOCKER|dcxgenai.azurecr.io/dcxgenai/dcx-genai-cx-foundry-image:ba3eb0cb3a20bac61d13445a559c52f1c123b1a2'
var appServicePlanName = 'ASP-${appName}-frontend'
var appServiceAppName = '${ResourcePrefix}-frontend-website'

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: WebAppLocation
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
  location: WebAppLocation
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
        siteConfig: {
      appSettings: [
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



resource sourceControl 'Microsoft.Web/sites/sourcecontrols@2022-09-01' = {
  parent: appServiceApp
  name: 'web'
  properties: {
    repoUrl: 'https://username:${pat}@github.com/manojsharmadcx/GenAIForCXFoundry'
    branch: 'feature/conversational-flow' // Your default GitHub branch
    isGitHubAction: true // Set to true to use GitHub Actions
    isManualIntegration: false // Set to false to enable automatic integration
    deploymentRollbackEnabled: false // Set based on your preference
    isMercurial: false // Set to false since you are using Git
    gitHubActionConfiguration: {
      // Uncomment and set the below fields if you are using GitHub Actions for a code repository
      codeConfiguration: {
        runtimeStack: 'NODE|16-lts' 
        runtimeVersion: '16' 
      }
      containerConfiguration: {
        serverUrl: 'https://dcxgenai.azurecr.io' // URL to your Azure Container Registry
        imageName: 'dcxgenai/dcx-genai-cx-foundry-image:ba3eb0cb3a20bac61d13445a559c52f1c123b1a2' // replace 'tag' with your specific image tag
        username: 'dcxgenai' // Your ACR username
        password: docker_password // Your ACR password
      }
      generateWorkflowFile: true // Set to true if you want to generate a GitHub Actions workflow file
      isLinux: true // Set to true if you are using a Linux app, otherwise set to false
    }
  }
}
