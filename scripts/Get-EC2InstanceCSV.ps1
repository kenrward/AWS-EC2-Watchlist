$credObj = Get-AutomationPSCredential -Name 'AWSCreds'
$AwsAccessKeyId = $credObj.UserName
$AwsSecretKey = $credObj.GetNetworkCredential().Password

# Set up the environment to access AWS
Set-AwsCredentials -AccessKey $AwsAccessKeyId -SecretKey $AwsSecretKey -StoreAs AWSProfile

$regions = Get-EC2Region -ProfileName AWSProfile -Region us-east-1  

foreach ($region in $regions) {
    $ec2instances = Get-EC2Instance -ProfileName AWSProfile -Region $region.RegionName

    ForEach($ec2 in $ec2instances){
        $csvdata += (Get-EC2Instance -InstanceId $ec2.Instances.InstanceId -ProfileName AWSProfile -Region $region.RegionName).Instances | ConvertTo-Csv -NoTypeInformation
    }
}
return $csvdata
