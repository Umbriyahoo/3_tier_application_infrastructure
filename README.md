# 3_tier_application_helecloud


### Repo content
```
main.tf - main Terraform configuration file 
ec2.userdata - contains bash script for deploying Apache server
network.tf - contains the network configuration 
output.tf - prints output for the resources deployed 
provider.tf - aws and region configuration
security.tf - containing SG configuration
terraform.tfvars - contains the deployment variables
variables.tf - contains variables default values 
```


### Prerequisites

#### To build the Terraform project
Install Terraform - [instructions](https://www.terraform.io/downloads)

#### You will need your aws Credetials
```
Linux
$export AWS_ACCESS_KEY_ID=...
$export AWS_SECRET_ACCESS_KEY=...

Windows
$Env:AWS_ACCESS_KEY_ID=...
$Env:AWS_SECRET_ACCESS_KEY=...
```
### Download the repo
```
https://github.com/Umbriyahoo/3_tier_application_helecloud-.git
```

### Set up the Terraform project

#### Instructions on how to run.

Run Terraform

    Create/Update resources - terraform apply
    Destroy resources - terraform destroy
