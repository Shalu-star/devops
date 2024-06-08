@description('The location in which all resources should be deployed.')
param location string = resourceGroup().location

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

@description('This is the base name for each Azure resource name (6-15 chars)')
param baseName string

param searchServiceName string

param searchServiceAdminKey string

param apiVersion string

param url string

param sendgridApiKey string = ''

param docker_password string

param azureFormRecoznizerKey string 

param azureFormRecoznizerEndpoint string

param emailConnectionString string 

param senderAddress string



var BackendImageName = 'DOCKER|dcxgenai.azurecr.io/dcxgenai/devstudio-image:95360b4f15c3d96d6a84683bd4f12d1edc0d696e'
var FrontendWebsiteUrl = 'https://${appName}.azurewebsites.net'
var appServicePlanName = 'ASP-${webAppName}-backend'
var appServiceAppName = webAppName
var blobContainerName = 'images'
var azureBlobConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${StorageAccount.name};AccountKey=${listKeys(StorageAccount.id,StorageAccount.apiVersion).keys[0].value};EndpointSuffix=core.windows.net'
var sqlServerName = 'sql${ResourcePrefix}'
var sqlDatabaseName = 'genaicxfoundryDb'
var dbpwd = 'root@123'
var dbUrl = 'Driver=${dbDriver};Server=tcp:${sqlServer.name}.database.windows.net,1433;Database=${sqlDatabaseName};Uid=${sqlServer.properties.administratorLogin};Pwd=${dbpwd};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;'
var sqlMessageHistoryDbUrl = 'mssql+pyodbc://${sqlServer.properties.administratorLogin}:${dbpwd}@{sqlServer.name}.database.windows.net:1433/${sqlDatabaseName}?driver=${dbDriver}'
var openaiName = 'oai-${baseName}'
var name = '${ResourcePrefix}-site-data-search'
var formRecognizerName = 'fr-${ResourcePrefix}'
var openaiEmbName = 'emb-${baseName}'


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
    name: 'gpt35-16k'
  }
  resource gpt4vision 'deployments' existing = {
    name: 'gpt-4-vision'
  }
  resource gpt35turbo 'deployments' existing = {
    name: 'gpt35'
  }
}

resource openAiAccountEmb 'Microsoft.CognitiveServices/accounts@2023-10-01-preview' existing = {
  name: openaiEmbName

  resource blockingFilter 'raiPolicies' existing = {
    name: 'blocking-filter'
  }
  resource embeddingsmall 'deployments' existing = {
    name: 'embedding-small'
  }
}

resource formRecognizer 'Microsoft.CognitiveServices/accounts@2022-12-01' existing = {
  name: toLower(formRecognizerName)
}

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
  dependsOn:[searchService,StorageAccount,sqlServer,openAiAccount,formRecognizer]
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
        siteConfig: {
      appSettings: [
        {name:  'AZURE_BLOB_ACCOUNT_NAME', value: StorageAccount.name}
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
        { name: 'Embeddings_OPENAI_API_KEY', value: listKeys(openAiAccount.id, '2023-10-01-preview').key1}
        { name: 'Embeddings_AZURE_ENDPOINT', value: reference(openAiAccount.id, '2023-10-01-preview').endpoint}
        { name: 'Embeddings_Deployment', value: 'embedding-genaidcx'}
        { name: 'Embeddings_OPENAI_API_VERSIONS', value: '2023-10-01-preview'}
        { name: 'Embeddings3_SMALL_OPENAI_API_KEY',value:listKeys(openAiAccountEmb.id, '2023-10-01-preview').key1}
        { name: 'Embeddings3_SMALL_AZURE_ENDPOINT',value:reference(openAiAccountEmb.id, '2023-10-01-preview').endpoint}
        { name: 'Embeddings3_SMALL_Deployment',value:'embedding-small'}
        { name: 'Embeddings3_SMALL_OPENAI_API_VERSIONS',value:'2023-10-01-preview'}
        { name: 'BASE16K_LLM_API_KEY', value: listKeys(openAiAccount.id, '2023-10-01-preview').key1}
        { name: 'BASE16K_LLM_API_BASE', value: reference(openAiAccount.id, '2023-10-01-preview').endpoint}
        { name: 'BASE16K_LLM_API_TYPE', value: 'azure'}
        { name: 'BASE16K_LLM_API_VERSION', value: '2023-10-01-preview'}
        { name: 'BASE16K_LLM_DEPLOYMENT_NAME', value: 'gpt35-16k'}
        { name: 'BASE16K_LLM_MODEL_VERSION', value: '0613'}
        { name: 'BASE_LLM_API_KEY', value: listKeys(openAiAccount.id, '2023-10-01-preview').key1}
        { name: 'BASE_LLM_API_BASE', value: reference(openAiAccount.id, '2023-10-01-preview').endpoint}
        { name: 'BASE_LLM_API_TYPE', value: 'azure'}
        { name: 'BASE_LLM_API_VERSION', value: '2023-10-01-preview'}
        { name: 'BASE_LLM_DEPLOYMENT_NAME', value: 'gpt35'}
        { name: 'BASE_LLM_MODEL_VERSION', value: '0613'}
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
        { name: 'GPT4_VISION_DEPLOYMENT_NAME', value: 'gpt-4-vision'}
        { name: 'GPT4_VISION_MODEL_VERSION', value: 'vision-preview'}
        { name: 'SEMANTIC_CACHE_ENABLED', value:'False'}
        { name: 'EXTERNAL_SEARCH_ENABLED', value:'False'}
        { name: 'VECTOR_STORE_PASSWORD', value:searchServiceAdminKey}
        { name: 'AZURE_SEARCH_SERVICE_NAME',value:searchServiceName}
        { name: 'VECTOR_STORE_ADDRESS',value: url}
        { name: 'API_VERSION',value: apiVersion}
        { name: 'DOCKER_REGISTRY_SERVER_URL',value:'https://dcxgenai.azurecr.io'}
        { name: 'DOCKER_REGISTRY_SERVER_USERNAME',value: 'dcxgenai'}
        { name: 'DOCKER_REGISTRY_SERVER_PASSWORD',value: docker_password}
        { name: 'SENDGRID_API_KEY',value:sendgridApiKey}
        { name: 'CUSTOM_QUESTION_ANSWERING_IMAGES',value:'Product-Selection,Openai-azure'}
        { name: 'CUSTOM_QUESTION_ANSWERING_PROJECT_CODE',value:'11000061'}
        { name: 'AZURE_FORM_RECOGNIZER_ENDPOINT',value:azureFormRecoznizerEndpoint}
        { name: 'AZURE_FORM_RECOGNIZER_KEY',value:azureFormRecoznizerKey}
        { name: 'FRONTEND_WEBSITE_URL',value:FrontendWebsiteUrl}
        { name: 'EMAIL_CONNECTION_STRING',value:emailConnectionString}
        { name: 'SENDER_ADDRESS',value:senderAddress}
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
