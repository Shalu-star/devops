@description('This is the base name for each Azure resource name (6-15 chars)')
param baseName string

@description('The resource group location')
param OPENAILocation string

//variables
var openaiName = 'oai-${baseName}'

resource openAiAccount 'Microsoft.CognitiveServices/accounts@2023-10-01-preview' = {
  name: openaiName
  location: OPENAILocation
  kind: 'OpenAI'
  properties: {
    customSubDomainName: 'openai${baseName}'
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
  sku: {
    name: 'S0'
  }

  @description('Fairly aggressive filter that attempts to block prompts and completions that are likely unprofessional. Tune to your specific requirements.')
  resource blockingFilter 'raiPolicies' = {
    name: 'blocking-filter'
    properties: {
      #disable-next-line BCP037
      type: 'UserManaged'
      basePolicyName: 'Microsoft.Default'
      mode: 'Default'
      contentFilters: [
        /* PROMPT FILTERS */
        {
          #disable-next-line BCP037
          name: 'hate'
          blocking: true
          enabled: true
          allowedContentLevel: 'Low'
          source: 'Prompt'
        }
        {
          #disable-next-line BCP037
          name: 'sexual'
          blocking: true
          enabled: true
          allowedContentLevel: 'Low'
          source: 'Prompt'
        }
        {
          #disable-next-line BCP037
          name: 'selfharm'
          blocking: true
          enabled: true
          allowedContentLevel: 'Low'
          source: 'Prompt'
        }
        {
          #disable-next-line BCP037
          name: 'violence'
          blocking: true
          enabled: true
          allowedContentLevel: 'Low'
          source: 'Prompt'
        }
        {
          #disable-next-line BCP037
          name: 'jailbreak'
          blocking: true
          enabled: true
          source: 'Prompt'
        }
        {
          #disable-next-line BCP037
          name: 'profanity'
          blocking: true
          enabled: true
          source: 'Prompt'
        }
        /* COMPLETION FILTERS */
        {
          #disable-next-line BCP037
          name: 'hate'
          blocking: true
          enabled: true
          allowedContentLevel: 'Low'
          source: 'Completion'
        }
        {
          #disable-next-line BCP037
          name: 'sexual'
          blocking: true
          enabled: true
          allowedContentLevel: 'Low'
          source: 'Completion'
        }
        {
          #disable-next-line BCP037
          name: 'selfharm'
          blocking: true
          enabled: true
          allowedContentLevel: 'Low'
          source: 'Completion'
        }
        {
          #disable-next-line BCP037
          name: 'violence'
          blocking: true
          enabled: true
          allowedContentLevel: 'Low'
          source: 'Completion'
        }
        {
          #disable-next-line BCP037
          name: 'profanity'
          blocking: true
          enabled: true
          source: 'Completion'
        }
      ]
    }
  }
}
// ---- Outputs ----
output openAiResourceName string = openAiAccount.name
