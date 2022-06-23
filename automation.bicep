@secure()
param credentials_AWSCreds_username string
param credentials_AWSCreds_password string
param automationAccounts_VMAuto_name string = 'EC2Automation'
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
    userName: credentials_AWSCreds_username
    password: credentials_AWSCreds_password
  }
}

resource automationAccounts_VMAuto_name_AWS_Tools_Common 'Microsoft.Automation/automationAccounts/modules@2020-01-13-preview' = {
  parent: automationAccounts_VMAuto_name_resource
  name: 'AWS.Tools.Common'
  properties: {
    contentLink: {}
    uri: ''
    version: ''
  }
}

resource automationAccounts_VMAuto_name_AWS_Tools_EC2 'Microsoft.Automation/automationAccounts/modules@2020-01-13-preview' = {
  parent: automationAccounts_VMAuto_name_resource
  name: 'AWS.Tools.EC2'
  properties: {
    contentLink: {}
    uri: ''
    version: ''
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
    publishContentLink: {
      uri: 'https://raw.githubusercontent.com/kenrward/AWS-EC2-Watchlist/main/scripts/Get-EC2InstanceJSON.ps1'
      version: '1.0.0.0'
    }
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
      uri: 'https://raw.githubusercontent.com/kenrward/AWS-EC2-Watchlist/main/scripts/Get-EC2InstanceCSV.ps1'
      version: '1.0.0.0'
    }
  }
}
