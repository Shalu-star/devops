targetScope = 'resourceGroup'

@description('The location in which all resources should be deployed.')
param embSmallLocation string

@description('This is the base name for each Azure resource name (6-15 chars)')
param baseName string

var openaiName = 'emb-${baseName}'

resource openAiAccountEmb 'Microsoft.CognitiveServices/accounts@2023-10-01-preview' = {
  name: openaiName
  location: embSmallLocation
  kind: 'OpenAI'
  properties: {
    customSubDomainName: 'emb${baseName}'
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


  @description('Add a embedding-genaidcx deployment.')
  // Ideally this would have been deployed in openai.bicep, but there is a race condition that happens
  // with newly created filters and deployments that use them, so they are seperated in this deployment
  // to avoid the issue in this one-shot process.
  resource embeddingsmall 'deployments' = {
    name: 'embedding-small'
    sku: {
      name: 'Standard'
      capacity: 5
    }
    properties: {
      model: {
        format: 'OpenAI'
        name: 'text-embedding-3-small'
        version: '1'
      }
      raiPolicyName: openAiAccountEmb::blockingFilter.name
      versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    }
  }
}
