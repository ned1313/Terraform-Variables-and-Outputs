# Base Web App Configuration

This basic web app configuration will deploy a VPC, EC2 instance, Secrets Manager secret, and S3 bucket in the us-west-2 region. During the *Terraform Inputs and Outputs* course you will make improvements to the configuration. Each section below details the desired changes for each module of the course.

Before you begin making changes, you should make a copy of the `base_app` directory and make your changes in that copy. Run one of the following commands depending on your shell:

```bash
# Linux and Mac
cp ./base_app ./working_app
```

```powershell
# PowerShell
Copy-Item -Recurse .\base_app\ .\working_app
```

## Module 1 - Using Input Variables

Your goal in this module is to make the following improvements to the code:

* Update all existing input variables to include a description and put them in alphabetical order.
* Add the following new input variables to the root module:
  * `instance_type`
  * `api_key`
  * `sg_port_number`
* Set the `api_key` input variable as sensitive
* Set a default of `80` for the `sg_port_number`
* Update the `main.tf` file with references to the new variables
* Add the `ec2_instance_role_arn` input variable to the `s3_bucket` module
* Uncomment the bucket policy and and policy document blocks in the `s3_bucket` module
* Update the module block for the s3 bucket to include the new `ec2_instance_role_arn` argument
* Update the `terraform.tfvars` file to include the `instance_type`
* Set the `api_key` value using an environment variable

## Module 2 - Input Variable Data Types

Your goal in this module is to make the following improvements to the code:

* Update all existing input variables to include a type argument.
* Add the new `vpc_network_info` of type `object` to include the VPC name, VPC CIDR, public subnet names, and public subnet CIDR.
* Update `networking` module to use the new `vpc_network_info` input variable
* Update the `azs` argument to get a slice equal to the number of public subnets
* Update the `terraform.tfvars` file to include a value for the `vpc_network_info` variable

## Module 3 - Local Values

Your goal in this module is to make the following improvements:

* Create `project` and `tags` input variables in the root module
* Create a `tags` input variable for the `s3_bucket` module
* Create a local value `naming_prefix` that is in the form of "project-environment"
* Create a `default_tags` local value including the environment and project values as tags
* Create local values for the name of each resource
* Update the configuration to use the new name values
* Update the `network` module, EC2 instance, and `s3_bucket` module to include tags

## Module 4 - Output Values

Your goal in this module is to make the following improvements:

* Add outputs to the `s3_bucket` module for the bucket arn, id, and policy
* Add outputs to the root module for the EC2 public dns, bucket info, and public subnet ids
  * The public subnet ids and `vpc_id` should be marked as sensitive
  * The bucket info output should include the bucket arn, id, and policy as a map
* All outputs should have a description and appear in alphabetical order
