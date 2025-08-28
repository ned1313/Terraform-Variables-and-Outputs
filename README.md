# Terraform-Variables-and-Outputs

Welcome to **Terraform - Variables and Outputs**.  These exercise files are meant to accompany my course on [Pluralsight](http://www.pluralsight.com/courses/terraform-variables-outputs).  The course was developed using version 1.12.2 of Terraform. This is the second course in the Terraform Learning Path on Pluralsight. I am assuming you have taken the **Getting Started - Terraform** course or you have equivalent knowledge.

## Using the files

In the course, you are given a Terraform configuration for a basic web application from someone else on the Globomantics team. We are going to make a copy of this configuration and modify it over the length of the course. The `base_app` directory has the basic web app configuration, which we will copy over to a new directory and start making alterations.

As we progress through the course, you will be challenged to make updates to the configuration to meet the evolving needs and requirements of the web application infrastructure. The completed solution for each module is in the `mX_solution` directories. I recommend trying to first write the solution yourself, and then checking your answer against what you see in the solution file.

Unlike some previous courses, I have not included the relevant commands for each module, as we're not doing anything remotely tricky with commands. It's just the usual `init`, `plan`, and `apply` stuff.

## AWS Environment

You will need access to an AWS environment with permissions to create resources in EC2 and S3. I recommend creating a dedicated account just for this course. The exercises have been tested with AWS region `us-east-1`. The input variable `aws_region` has `us-west-2` set as the default, but you can supply a different region if you prefer. Generally, the exercises should work in any region that has the Amazon Linux 2 AMI and `t3.micro` size instances (although you can adjust that as well).

You may get an error in some cases that the current availability zone has no available `t3.micro` instance types! **This is an issue with AWS and not your code.** I chose to use `us-west-2` instead of the more popular `us-east-1` to try and avoid such capacity issues. Nevertheless, `t3.micro` is a favorite since it is in the Free Tier, so you may still get periodic capacity errors.

You will need to generate an AWS access key to run through the exercises. You can do this through the IAM console in a browser (*hint*: it's under security credentials for your user) by following the [official AWS docs](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/). I'd recommend assigning the `AdministratorAccess` policy to your user to give you permissions to do everything in the account. Also, enable 2FA for the user account!

The exercises assume you have configured your AWS CLI with the relevant credentials or set environment variables for authentication. If you're unsure about how to do this, I refer you to the [authentication options in the AWS provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration). The short, short version is:

```bash
# Using the AWS CLI
aws configure
```

Enter your Access Key and Secret Access Key at the prompts. Or:

```bash
# Using environment variables
# PowerShell
$env:AWS_ACCESS_KEY_ID="YOURACCESSKEYID"
$env:AWS_SECRET_ACCESS_KEY="YOURSECRETACCESSKEY"

# Bash
export AWS_ACCESS_KEY_ID="YOURACCESSKEYID"
export AWS_SECRET_ACCESS_KEY="YOURSECRETACCESSKEY"
```

## MONEY!!!

A gentle reminder about cost.  The course will have you creating resources in AWS.  AWS recently replaced their original free tier offering with a new [Free Plan account](https://aws.amazon.com/free/) that includes up to $200 in credits and some always free services. If you open a new account after July 2025, you should be able to use that account with this course and not incur any costs.

The new Free Plan does limit your consumption of services. To avoid hitting that limit, you should remove resources when not actively taking the course. When you complete an exercise in the course, you can easily tear down the deployed infrastructure using `terraform destroy`. Just run that command and approve the destruction to remove all resources from AWS. Before you start the next module, run `terraform apply` again and you should be right where you started. Isn't infrastructure automation amazing?!

## Certification

HashiCorp offers the Terraform Certified Associate certification. You might be wondering if this course fully prepares you for the cert.  **It does not.**  Taking this course along with the rest of the Terraform learning path on Pluralsight should cover all the objectives on the exam and give you the knowledge you need to pass.

I have coauthored a certification guide which you can find on [Leanpub](https://leanpub.com/terraform-certified/). This is an unofficial guide, but I believe in concert with the Pluralsight courses you will be in a good position to sit the exam. And in case you're wondering, yes it is fully updated for version 003 of the exam that was released in May 2023.

## Conclusion

I hope you enjoy taking this course as much as I did creating it.  I'd love to hear feedback and suggestions for revisions. Find me on LinkedIn (https://www.linkedin.com/in/ned-bellavance/) or add an issue to this repository.

Thanks and happy automating!

Ned
