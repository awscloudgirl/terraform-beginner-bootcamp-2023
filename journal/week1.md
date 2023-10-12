# Terraform Beginners Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:
```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:

- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag

You can configure Terraform input variables using the -var flag, which allows you to set or override variables specified in .tfvars files. For instance:
```
terraform apply -var user_uuid=0000-...
```
This command will override the predefined variable values in other files with the specified input.

### var-file flag

When dealing with multiple variables needed in your Terraform commands, it's more convenient to manage them in a single file. You can define all your variables within a file, whether it's in .tfvars or .tfvars.json format, and then reference the file using the -var-file flag. For example:
```
terraform apply -var-file="bulkvalues.tfvars"
```
### terraform.tvfars

By default, Terraform loads variables from the terraform.tfvars file. This file serves as a central repository for your variable configurations, making it easy to manage variables in bulk.

### auto.tfvars

Terraform automatically loads variable definitions from various sources in a specific order of precedence, prioritizing them from top to bottom and left to right:

- Any .auto.tfvars or .auto.tfvars.json files are processed in lexical order of their filenames.
- Files with names ending in .auto.tfvars or .auto.tfvars.json.
- Files named exactly terraform.tfvars.json or terraform.tfvars.
- This sequence ensures that variables are loaded according to their designated importance and specificity.

## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import
```
terraform import aws_s3_bucket.bucket bucket-name
```
[Terraform Import](https://developer.hashicorp.com/terraform/cli/import) 
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps.

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift