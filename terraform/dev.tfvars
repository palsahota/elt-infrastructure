account_no = "889146076393"
 
region = "us-west-2"
    
profile = "target"

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