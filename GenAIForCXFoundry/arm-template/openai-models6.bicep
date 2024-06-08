targetScope = 'resourceGroup'

@description('This is the base name for each Azure resource name (6-15 chars)')
param baseName string

var openaiName = 'oai-${baseName}'

resource openAiAccount 'Microsoft.CognitiveServices/accounts@2023-10-01-preview' existing = {
  name: openaiName

  resource blockingFilter 'raiPolicies' existing = {
    name: 'blocking-filter'
  }

  @description('Add a gpt-35-turbo-16k  deployment.')
  // Ideally this would have been deployed in openai.bicep, but there is a race condition that happens
  // with newly created filters and deployments that use them, so they are seperated in this deployment
  // to avoid the issue in this one-shot process.
  resource gpt35turbo 'deployments' = {
    name: 'gpt35'
    sku: {
      name: 'Standard'
      capacity: 5
    }
    properties: {
      model: {
        format: 'OpenAI'
        name: 'gpt-35-turbo'
        version: '0613'
      }
      raiPolicyName: openAiAccount::blockingFilter.name
      versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    }
  }
}
