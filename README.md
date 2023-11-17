# CI/CD Pipeline with CodePipeline, CloudFormation from source code in BitBucket

This projects cover the Ci/CD process in 3 different accounts: dev, uat and prod.
The pipeline in dev is trigger automatically, however, in uat and prod are set to manual releases to avoid accidental releases and have better control.

This project is compose of: 
- A CloudFormation (will be referenced as cfn) stack that deploys an s3 bucket where the pipelines artifacts will be stored.
- A cfn stack that creates a role policy that will be used by AWS resources (CodePipeline, CloudFormation...) to run the CI/CD Pipelines. It is located under the folder Pipelines-Role.
- A cfn stack to deploy the core-network pipeline. It picks up code changes from dev-deployment, uat-deployment or prod-deployment branches (according to the environment).
- A cfn stack to deploy the application pipeline. It picks up code changes from dev-deployment, uat-deployment or prod-deployment branches (according to the environment).

These 4 cfn stacks are deployed using the following scripts dev_cli_script.sh, uat_cli_script.sh and prod_cli_script.sh. The only different between them is the parameter "environment" which is set to each environment (accordingly).

## Stages in the pipelines

### **Core-Network Pipeline**

The stages are the following:
- Source: A connection to the repository in BitBucket. Please note that after the initial deployment the pipeline will fail as the CodeStar connection will need to be manually updated in Connections.
- VPC:it creates/updates **vpc_cloudformation.yaml**. This file is located under Templates/core-network
- Subnets:it creates/updates **subnets_cloudformation.yaml**. This file is located under Templates/core-network

Important! VPC and Subnet stages use static json files that overwrite some parameters for master control and tagging. They are located under Template-Configuration.

### **Application Pipeline**

The stages are the following:
- Source: A connection to the repository in BitBucket. Please note that after the initial deployment the pipeline will fail as the CodeStar connection will need to be manually updated in Connections.
- App-Cluster:it creates/updates **app-cluster_cloudformation.yaml**. This file is located under Templates/application
- Welcome-api:it creates/updates **welcome-api_cloudformation.yaml**. This file is located under Templates/application


The architecture of this application is the following:

![Architecture.png](..%2F..%2Fapplication%2Fapp%2FArchitecture.png)

Here is a deeper dive into what is being created by each cfn stack:

#### **Core Network**

It creates the underlying infrastructure of the application.
**vpc_cloudformation.yaml** --> creates a vpc, internet gateway.
**subnets_cloudformation.yaml** --> creates 2 public subnets (in 2 different AZs) with public ip on launch. 

#### **Application**

I covers the deployment of the application resources.
**app-cluster_cloudformation.yaml** --> It creates an ecs cluster and the components of an application load balancer, as well as cloudwatch logs.
**welcome-api_cloudformation.yaml** --> It deploys an ECS Task definition, ECS service using Fargate launchtype, and ALB Target Group and Listener rule.

For this project, a simple docker image has been created and pushed to AWS ECR. You can view the steps in the app folder.