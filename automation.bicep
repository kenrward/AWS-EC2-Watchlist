@secure()
param credentials_AWSCreds_password string
param automationAccounts_VMAuto_name string = 'VMAuto'
param location string = 'eastus2'

resource automationAccounts_VMAuto_name_resource 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: automationAccounts_VMAuto_name
  location: location
  properties: {
    sku: {
      name: 'Basic'
    }
    encryption: {
      keySource: 'Microsoft.Automation'
      identity: {}
    }
  }
}

resource automationAccounts_VMAuto_name_AWSCreds 'Microsoft.Automation/automationAccounts/credentials@2020-01-13-preview' = {
  parent: automationAccounts_VMAuto_name_resource
  name: 'AWSCreds'
  properties: {
    userName: 'AKIA5ETAX24JG6XTRGEV'
    password: credentials_AWSCreds_password
  }
}

resource automationAccounts_VMAuto_name_AWS_Tools_Common 'Microsoft.Automation/automationAccounts/modules@2020-01-13-preview' = {
  parent: automationAccounts_VMAuto_name_resource
  name: 'AWS.Tools.Common'
  properties: {
    contentLink: {}
  }
}

resource automationAccounts_VMAuto_name_AWS_Tools_EC2 'Microsoft.Automation/automationAccounts/modules@2020-01-13-preview' = {
  parent: automationAccounts_VMAuto_name_resource
  name: 'AWS.Tools.EC2'
  properties: {
    contentLink: {}
  }
}

resource automationAccounts_VMAuto_name_GetAWSInstanceJSON 'Microsoft.Automation/automationAccounts/runbooks@2019-06-01' = {
  parent: automationAccounts_VMAuto_name_resource
  name: 'GetAWSInstanceJSON'
  location: location
  properties: {
    runbookType: 'PowerShell'
    logVerbose: false
    logProgress: false
    logActivityTrace: 0
  }
}

resource automationAccounts_VMAuto_name_GetAWSInstanceCSV 'Microsoft.Automation/automationAccounts/runbooks@2019-06-01' = {
  parent: automationAccounts_VMAuto_name_resource
  name: 'GetAWSInstanceCSV'
  location: location
  properties: {
    runbookType: 'PowerShell'
    logVerbose: false
    logProgress: false
    logActivityTrace: 0
    publishContentLink: {
      uri: 'https://test.ps1'
      version: '1.0.0.0'
    }
  }
}
