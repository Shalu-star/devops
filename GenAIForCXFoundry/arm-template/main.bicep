@description('The location in which all resources should be deployed.')
param location string = resourceGroup().location

@description('The location in which all resources should be deployed.')
param OPENAILocation string 

@description('The location in which all resources should be deployed.')
param embSmallLocation string

@description('provide a 2-13 character prefix for all resources.')
param ResourcePrefix string

@description('This is the base name for each Azure resource name (6-8 chars)')
@minLength(6)
@maxLength(8)
param baseName string

@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string

@description('The administrator login password for the SQL server.')

param sqlServerAdministratorLoginPassword string


param docker_password string

param sendgridApiKey string

// Deploy Azure OpenAI service 
module openaiModule 'openai.bicep' = {
  name: 'openaiDeploy'
  params: {
    OPENAILocation: OPENAILocation
    baseName: baseName
  }
}


// Deploy the gpt 3.5 model within the Azure OpenAI service deployed above.
module openaiModels1 'openai-models1.bicep' = {
  name: 'openaiModelsDeploy1'
  params:{
    baseName:baseName
  }
  dependsOn:[openaiModule]
}


// Deploy the gpt 4 model within the Azure OpenAI service deployed above.
module openaiModels2 'openai-models2.bicep' = {
  name: 'openaiModelsDeploy2'
  params: {
    baseName:baseName
  }
  dependsOn:[openaiModule,openaiModels1]
}

// Deploy the gpt 4 vision model within the Azure OpenAI service deployed above.
module openaiModels3 'openai-models3.bicep' = {
  name: 'openaiModelsDeploy3'
  params: {
    baseName:baseName
  }
  dependsOn:[openaiModule,openaiModels1,openaiModels2]
}

// Deploy the embedding-genaidcx within the Azure OpenAI service deployed above.
module openaiModels4 'openai-models4.bicep' = {
  name: 'openaiModelsDeploy4'
  params: {
    baseName:baseName
  }
  dependsOn:[openaiModule,openaiModels1,openaiModels2,openaiModels3]
}

// Deploy the embedding-genaidcx within the Azure OpenAI service deployed above.
module openaiModels5 'openai-models5.bicep' = {
  name: 'openaiModelsDeploy5'
  params: {
    baseName:baseName
    embSmallLocation:embSmallLocation
  }
  dependsOn:[]
}

// Deploy the embedding-genaidcx within the Azure OpenAI service deployed above.
module openaiModels6 'openai-models6.bicep' = {
  name: 'openaiModelsDeploy6'
  params: {
    baseName:baseName
  }
  dependsOn:[openaiModule,openaiModels1,openaiModels2,openaiModels3,openaiModels4]
}

// Deploy storage account 
module storageModule 'storage.bicep' = {
  name: 'storageDeploy'
  params: {
    location: location
    ResourcePrefix: ResourcePrefix
  }
}

// Deploy database
module databaseModule 'database.bicep' = {
  name: 'databaseDeploy'
  params: {
    location:location
    ResourcePrefix: ResourcePrefix
    sqlServerAdministratorLogin: sqlServerAdministratorLogin
    sqlServerAdministratorLoginPassword: sqlServerAdministratorLoginPassword
  }
  dependsOn:[]
}

//Deploy Azure Search Service
module azureSearchServiceModule 'azure-search-service.bicep' = {
  name:'azureSearchServiceDeploy'
  params:{
    ResourcePrefix:ResourcePrefix
    location:location
  }
}

//Deploy Azure Form Recoznizer
module azureFormRecoznizerModule 'azure-form-recognizer.bicep' = {
  name:'azureFormRecoznizerDeploy'
  params:{
    location:location
    ResourcePrefix:ResourcePrefix
  }
}

// Communication Service
module communicationServiceModule 'communication-service.bicep' = {
  name:'communicationServiceDeploy'
  params:{
    ResourcePrefix:ResourcePrefix
  }
}

// Deploy Frontend-service
module frontendServiceModule 'frontend-web-app.bicep' = {
  name: 'frontendServiceDeploy'
  params: {
    location: location
    ResourcePrefix: ResourcePrefix
    docker_password:docker_password
  }
  dependsOn:[]
}

// Deploy Backend-service
module backendServiceModule 'backend-web-app.bicep' = {
  name: 'backendServiceDeploy'
  params: {
    location: location
    ResourcePrefix: ResourcePrefix
    baseName:baseName
    searchServiceName:azureSearchServiceModule.outputs.searchServiceName
    searchServiceAdminKey:azureSearchServiceModule.outputs.searchServiceAdminKey
    docker_password:docker_password
    url: azureSearchServiceModule.outputs.vector_store_address
    apiVersion:azureSearchServiceModule.outputs.apiVersion
    azureFormRecoznizerEndpoint:azureFormRecoznizerModule.outputs.formRecoznizerEndPoint
    azureFormRecoznizerKey:azureFormRecoznizerModule.outputs.formRecoznizerKey
    sendgridApiKey:sendgridApiKey
    emailConnectionString:communicationServiceModule.outputs.communicationServiceConnectionString
    senderAddress:communicationServiceModule.outputs.senderAddressOutput
  }
  dependsOn:[azureSearchServiceModule,storageModule,databaseModule,frontendServiceModule,openaiModule,openaiModels1,openaiModels2,openaiModels3,openaiModels4,openaiModels5,openaiModels6,azureFormRecoznizerModule,communicationServiceModule]
}
