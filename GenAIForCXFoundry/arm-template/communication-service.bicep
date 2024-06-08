@description('provide a 2-13 character prefix for all resources.')
param ResourcePrefix string
var communicationServiceName='cs-${ResourcePrefix}'
var emailServiceName = 'es-${ResourcePrefix}'

// Email Communication Service
resource emailService 'Microsoft.Communication/emailServices@2023-03-31' = {
  name: emailServiceName
  location: 'global'
  properties: {
    dataLocation: 'United States'
  }
}

// Email Communication Services Domain (Azure Managed)
resource emailServiceAzureDomain 'Microsoft.Communication/emailServices/domains@2023-03-31'={
  parent: emailService
  name: 'AzureManagedDomain'
  location: 'global'
  properties: {
    domainManagement: 'AzureManaged'
    userEngagementTracking: 'Disabled'
  }
}

// SenderUsername (Azure Managed Domain)
resource senderUserNameAzureDomain 'Microsoft.Communication/emailServices/domains/senderUsernames@2023-03-31'={
  parent: emailServiceAzureDomain
  name: 'donotreply'
  properties: {
    username: 'DoNotReply'
    displayName: 'DoNotReply'
  }
}

// Communication Service
resource communcationService 'Microsoft.Communication/communicationServices@2023-03-31' = {
  name: communicationServiceName
  location: 'global'
  properties: {
    dataLocation: 'United States'
    linkedDomains: [
      emailServiceAzureDomain.id
    ]
  }
}
// Construct the senderAddress
var senderAddress = '${senderUserNameAzureDomain.properties.username}@${emailServiceAzureDomain.properties.fromSenderDomain}'

output communicationServiceConnectionString string = listKeys(communcationService.name, '2023-03-31').primaryConnectionString
output senderAddressOutput string = senderAddress



