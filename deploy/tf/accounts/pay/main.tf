terraform {
  backend "s3" {
    bucket  = "circle-tf-pay-us-east-1"
    key     = "fluentd-kubernetes-daemonset"
    region  = "us-east-1"
    encrypt = "true"
    dynamodb_table = "circle-tf-pay-lock-us-east-1"
  }
}

module "codebuild" {
  source = "../../lib/codepipeline"

  region                  = "us-east-1"
  account                 = "platform"
  github_oauth_secret_id  = "arn:aws:secretsmanager:us-east-1:908968368384:secret:/ops/utilities/github/platform/wallets-api/oauth-gZvZTF"
  name                    = "fluentd"
  owner                   = "circlefin"
  repo                    = "fluentd-kubernetes-daemonset"
  vpc_id                  = "vpc-0ea540b10a280189a"
  vpc_subnets             = ["subnet-0ff4773434c4d191d", "subnet-0a5f810f8cdf5c2eb", "subnet-0f21f70495bf7f90b", "subnet-0afdf4cd3434cd3d6", "subnet-0d9b5af8814a65255", "subnet-0e852da489baf856d"]
}
