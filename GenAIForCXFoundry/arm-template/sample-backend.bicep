@description('The location in which all webapp resources should be deployed.')
param WebAppLocation string 

@description('provide a 2-13 character prefix for all resources.')
param ResourcePrefix string

@description('Backend Web app name.')
param webAppName string = '${ResourcePrefix}-backend-website'

@description('Frontend Web app name.')
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

@description('Name of Storage Account')
param StorageAccountName string = '${ResourcePrefix}str'

@allowed(['ODBC Driver 18 for SQL Server','SQL SERVER'])
@description('Driver')
param dbDriver string = 'ODBC Driver 18 for SQL Server'

@description('Decorated driver')
param dbDecoratedDriver string = 'ODBC+Driver+18+for+SQL+Server'

@description('TAVILY_API_KEY')
param tavilyApiKey string 

@description('This is the base name for each Azure resource name (6-15 chars)')
param baseName string

@description('Redis Endpoint')
param redisEndpoint string

@description('Redis password')
param redisPassword string

param searchServiceName string

param searchServiceAdminKey string

@secure()
param docker_password string

@secure()
param pat string

var BackendImageName = 'DOCKER|dcxgenai.azurecr.io/dcxgenai/devstudio-image:7ce40c3a260699d418636b51e8199fe44773b77d'
var FrontendWebsiteUrl = 'https://${appName}.azurewebsites.net'
var appServicePlanName = 'AppServicePlan-${webAppName}-backend'
var appServiceAppName = webAppName
var blobContainerName = 'images'
var azureBlobConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${StorageAccount.name};AccountKey=${listKeys(StorageAccount.id,StorageAccount.apiVersion).keys[0].value};EndpointSuffix=core.windows.net'
var sqlServerName = 'sql${ResourcePrefix}'
var sqlDatabaseName = 'genaicxfoundryDb'
var dbpwd = 'root@123'
var dbUrl = 'Driver=${dbDriver};Server=tcp:${sqlServer.name}.database.windows.net,1433;Database=${sqlDatabaseName};Uid=${sqlServer.properties.administratorLogin};Pwd=${dbpwd};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;'
var sqlMessageHistoryDbUrl = 'mssql+pyodbc://${sqlServer.properties.administratorLogin}:${dbpwd}@{sqlServer.name}.database.windows.net:1433/${sqlDatabaseName}?driver=${dbDriver}'
var openaiName = 'openai-${baseName}'
var name = '${ResourcePrefix}-site-data-search'


resource StorageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' existing = {
  name: StorageAccountName
}

resource sqlServer 'Microsoft.Sql/servers@2021-11-01-preview' existing= {
  name: sqlServerName
}

resource searchService 'Microsoft.Search/searchServices@2020-08-01' existing = {
  name: name
}

resource openAiAccount 'Microsoft.CognitiveServices/accounts@2023-10-01-preview' existing = {
  name: openaiName

  resource blockingFilter 'raiPolicies' existing = {
    name: 'blocking-filter'
  }

  resource gpt4 'deployments' existing = {
    name: 'gpt4'
  }

  resource embedding 'deployments' existing = {
    name: 'embedding-genaidcx'
  }
  resource gpt35 'deployments' existing = {
    name: 'gpt35'
  }
  resource gpt4vision 'deployments' existing = {
    name: 'gpt-4'
  }
}


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
  dependsOn:[searchService,StorageAccount,sqlServer,openAiAccount]
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: WebAppLocation
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
        siteConfig: {
      appSettings: [
        {name: 'AZURE_BLOB_ACCOUNT_NAME', value: StorageAccount.name}
        { name: 'AZURE_BLOB_ACCOUNT_KEY', value: listKeys(StorageAccount.id, '2023-01-01').keys[0].value }
        { name: 'AZURE_BLOB_CONTAINER_NAME', value: blobContainerName }
        { name: 'AZUREBLOB_EXPIRY_DAYS', value: '30' }
        { name: 'AZUREBLOB_CONNECTION_STRING', value: azureBlobConnectionString}
        { name: 'SQL_SERVER_NAME', value: sqlServer.name}
        { name: 'DB_DRIVER', value: dbDriver}
        { name: 'SQL_DATABASE_NAME', value: sqlDatabaseName}
        { name: 'SQL_ADMIN_NAME', value: sqlServer.properties.administratorLogin}
        { name: 'SQL_ADMIN_PASSWORD', value: dbpwd}
        { name: 'DB_URL', value:dbUrl}
        { name: 'DB_DRIVER_DECORATOR', value: dbDecoratedDriver}
        { name: 'SQLMESSAGEHISTORY_DB_URL', value:sqlMessageHistoryDbUrl}
        { name: 'TAVILY_API_KEY', value: tavilyApiKey}
        { name: 'Embeddings_OPENAI_API_KEY', value: listKeys(openAiAccount.id, '2023-10-01-preview').key1}
        { name: 'Embeddings_AZURE_ENDPOINT', value: reference(openAiAccount.id, '2023-10-01-preview').endpoint}
        { name: 'Embeddings_Deployment', value: 'embedding-genaidcx'}
        { name: 'Embeddings_OPENAI_API_VERSIONS', value: '2023-10-01-preview'}
        { name: 'BASE_LLM_API_KEY', value: listKeys(openAiAccount.id, '2023-10-01-preview').key1}
        { name: 'BASE_LLM_API_BASE', value: reference(openAiAccount.id, '2023-10-01-preview').endpoint}
        { name: 'BASE_LLM_API_TYPE', value: 'azure'}
        { name: 'BASE_LLM_API_VERSION', value: '2023-10-01-preview'}
        { name: 'BASE_LLM_DEPLOYMENT_NAME', value: 'gpt35'}
        { name: 'BASE_LLM_MODEL_VERSION', value: '1106'}
        { name: 'GPT4_API_KEY', value: listKeys(openAiAccount.id, '2023-10-01-preview').key1}
        { name: 'GPT4_API_BASE', value: reference(openAiAccount.id, '2023-10-01-preview').endpoint}
        { name: 'GPT4_API_TYPE', value: 'azure'}
        { name: 'GPT4_API_VERSION', value: '2023-10-01-preview'}
        { name: 'GPT4_API_DEPLOYMENT_NAME', value: 'gpt4'}
        { name: 'GPT4_API_MODEL_VERSION', value: '0613'}
        { name: 'GPT4_VISION_API_KEY', value: listKeys(openAiAccount.id, '2023-10-01-preview').key1}
        { name: 'GPT4_VISION_API_BASE', value: reference(openAiAccount.id, '2023-10-01-preview').endpoint}
        { name: 'GPT4_VISION_API_TYPE', value: 'azure'}
        { name: 'GPT4_VISION_API_VERSION', value: '2023-10-01-preview'}
        { name: 'GPT4_VISION_DEPLOYMENT_NAME', value: 'gpt4'}
        { name: 'GPT4_VISION_MODEL_VERSION', value: 'vision-preview'}
        { name:  'REDIS_ENDPOINT', value: redisEndpoint}
        { name: 'REDIS_PASSWORD', value:redisPassword}
        { name: 'SEMANTIC_CACHE_ENABLED', value:'False'}
        { name: 'EXTERNAL_SEARCH_ENABLED', value:'False'}
        { name: 'AZURE_SEARCH_ADMIN_KEY', value:searchServiceAdminKey}
        { name: 'AZURE_SEARCH_SERVICE_NAME',value:searchServiceName}
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
      ]
      cors: {
        allowedOrigins: [
          'https://portal.azure.com',FrontendWebsiteUrl
        ]
      }
      use32BitWorkerProcess: false
      linuxFxVersion: BackendImageName
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
    repoUrl: 'https://username:$${pat}@github.com/manojsharmadcx/dcxgenaidevstudio'
    branch: 'feature/conversational-flow' // Your default GitHub branch
    isGitHubAction: true // Set to true to use GitHub Actions
    isManualIntegration: false // Set to false to enable automatic integration
    deploymentRollbackEnabled: false // Set based on your preference
    isMercurial: false // Set to false since you are using Git
    gitHubActionConfiguration: {
      // Uncomment and set the below fields if you are using GitHub Actions for a code repository
      codeConfiguration: {
        runtimeStack: 'PYTHON|3.10' // Example for Python 3.10, if supported by Azure App Service
        runtimeVersion: '3.10' // Specify the version of Python you are using
      }
      containerConfiguration: {
        serverUrl: 'https://dcxgenai.azurecr.io' // URL to your Azure Container Registry
        imageName: 'dcxgenai/devstudio-image:7ce40c3a260699d418636b51e8199fe44773b77d' // replace 'tag' with your specific image tag
        username: 'dcxgenai' // Your ACR username
        password: docker_password // Your ACR password
      }
      generateWorkflowFile: true // Set to true if you want to generate a GitHub Actions workflow file
      isLinux: true // Set to true if you are using a Linux app, otherwise set to false
    }
  }
}

