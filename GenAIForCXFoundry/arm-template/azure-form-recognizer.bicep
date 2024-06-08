@description('provide a 2-13 character prefix for all resources.')
param ResourcePrefix string
@description('Location for resource.')
param location string

var formRecognizerName = 'afr-${ResourcePrefix}'


resource formRecognizer 'Microsoft.CognitiveServices/accounts@2022-12-01'={
  name: toLower(formRecognizerName)
  location: location
  kind: 'FormRecognizer'
  sku: {
    name: 'S0'
  }
  properties: {
    customSubDomainName: formRecognizerName
  }
  identity: {
    type: 'SystemAssigned'
  }

}

output formRecoznizerEndPoint string= formRecognizer.properties.endpoint 

output formRecoznizerKey string = listKeys(formRecognizer.id,'2022-12-01').key1



