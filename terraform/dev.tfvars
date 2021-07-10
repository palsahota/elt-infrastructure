account_no = "235485217844"
 
region = "us-west-2"
    
profile = "default"

name = "test-eks"

environment = "dev"

BitBucketSourceRepo = "https://vgoel88@bitbucket.org/vgoel88/test-eks.git"

BitBucketBranch = "master"

BitBucketToken = "XzdtCs95tJS2TrfpK4pG"

BitBucketUser = "vgoel88"

CodeBuildDockerImage = "aws/codebuild/standard:4.0"

#KubectlRoleName = 

pipeline_artifact_bucket = "s3-codebuild-bucket"

mwaa_bucket = "s3-mwaa-bucket"

ec2_ssh_key = "vineet_test"

main_vpc = "snap-dl-dev-vpc"

private_subnet1 = "snap-dl-dev-tga-2a"

private_subnet2 = "snap-dl-dev-tga-2b"

private_subnet3 = "snap-dl-dev-tga-2c"

default_tags = {
    Brand                = "Monetize"
    Team                 = "DataPlatformTeam"
    Application          = "Datalake"
    #AssetProtectionLevel = ""
    #CostCenter           = ""
    DataClassification   = "Sensitive"
    Creator              = "Terraform"
    Environment          = "Development"
}