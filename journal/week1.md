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
```sh
terraform apply -var user_uuid=0000-...
```
This command will override the predefined variable values in other files with the specified input.

### var-file flag

When dealing with multiple variables needed in your Terraform commands, it's more convenient to manage them in a single file. You can define all your variables within a file, whether it's in .tfvars or .tfvars.json format, and then reference the file using the -var-file flag. For example:
```sh
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

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift.

## Terraform Modules

### Terraform Module Structure

It is recommend to place modules in a modules directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module. The module has to declare the terraform variables in its own variables.tf
```sh
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```
### Modules Sources

Using the source we can import the module from various places eg:

- locally
- Github
- Terraform Registry
```sh
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```
[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples that could be deprecated. Often affecting providers.

## Working with Files in Terraform

### Fileexists function

This is a built in terraform function to check the existance of a file.
```sh
condition = fileexists(var.error_html_filepath)
```
https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

In terraform there is a special variable called path that allows us to reference local paths:

- path.module = get the path for the current module
- path.root = get the path for the root module [Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)
```
resource "aws_s3_object" "index_html" { bucket = aws_s3_bucket.website_bucket.bucket key = "index.html" source = "${path.root}/public/index.html" }
```

## Correcting Tags

[How to delete local and remote tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

How to remove both local and remote tags in Git

### Locally delete a tag:
```bash
git tag -d <tag_name>
```
### Remotely delete a tag:

```bash
git push --delete origin <tag_name>
```
### Fixing Previous Tags (non-HEAD tags):

Checkout the commit you want to re-tag:

```bash
git checkout <commit_SHA>
```
### Obtain the commit SHA from your GitHub commit history.

Retag the commit with the new tag:
```bash
git tag <new_tag_name>
```
### Push the new tag to the remote repository:

```bash
git push --tags
```
Switch back to the main branch:
```bash
git checkout main
```
