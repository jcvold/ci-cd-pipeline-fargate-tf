module "vpc" {
  source  = "aws-ia/vpc/aws"
  version = ">= 4.0.0"

  name       = "ci-cd-bg-tf"
  cidr_block = "10.0.0.0/16"
  az_count   = 3

  subnets = {
    public = {
      # name_prefix               = "my_public" # omit to prefix with "public"
      cidrs                     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
      nat_gateway_configuration = "single_az" # options: "single_az", "none"
    }

    private_app = {
      # omitting name_prefix defaults value to "private_app"
      # name_prefix  = "private_app"
      cidrs                   = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
      connect_to_public_natgw = true
    }

    # private_rds = {
    #   # omitting name_prefix defaults value to "private_rds"
    #   # name_prefix             = "private_rds"
    #   cidrs                   = ["10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
    #   connect_to_public_natgw = false
    # }
  }
}
