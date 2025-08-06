# Base Web App Configuration

This basic web app configuration will deploy a VPC, EC2 instance, Secrets Manager secret, and S3 bucket in the us-west-2 region. During the Terraform Inputs and Outputs course you will make improvements to the configuration. Each section below details the desired changes for each module of the course.

Before you begin making changes, you should make a copy of the `base_app` directory and make your changes in that copy. Run one of the following commands depending on your shell:

```bash
# Linux
cp ./base_app ./working_app
```

```powershell
# PowerShell
Copy-Item -Recurse .\base_app\ .\working_app
```

## Module 1 - Input Variable Basics

Your goal in this module is to make the following improvements to the code:

* Update all existing input variables to include a description
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

## Module 2 - Input Variable Data Types

## Module 3 - Local Values

## Module 4 - Output Values

## Future Enhancements (Input Variables topic)

Add a complex object variable to define VPC and subnet CIDRs together.

Mark ami_id as sensitive = true.

Add validation to instance_type.

Add a map or list of EC2 tags.

Update the storage module inputs to use new variable structure.

## Future Enhancements (Output Values topic)

Add description for outputs.

Use sensitive = true for sensitive outputs.

Add new outputs from the locals.

Update child module to expose more useful values (ARN, region, etc).

## Future Enhancements (Child Module)

Accept additional inputs (e.g. enable_versioning, tags).

Add validations.

Add outputs for ARN, versioning, etc.

## Future locals Usage Ideas

In the next lesson, locals can be added for:

Default tags reused across resources.

Deriving name strings like "web-${var.environment}".

Selecting AMI based on region.

Combining map or list data for lookup behavior.
