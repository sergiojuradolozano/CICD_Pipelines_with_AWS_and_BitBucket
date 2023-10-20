#RUN THIS SCRIPT IN THE LOCATION WHERE THE FILES ARE IN.

#CREATE OR UPDATE THE CLOUDFORMATION STACK OF THE Pipelines Role
aws cloudformation deploy --template-file ./Pipelines-Role/CodePipelines-Role.yaml --stack-name CodePipelines-Role --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --parameter-overrides Environment=dev Region=us-east-1 #See comment on the Region parameter in the cloudformation stacks.

#CREATE OR UPDATE THE CLOUDFORMATION STACK OF THE CORE NETWORK
aws cloudformation deploy --template-file ./Pipelines/Core-Network-CodePipeline.yaml --stack-name Core-Network-CodePipeline --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --parameter-overrides Environment=dev Region=us-east-1 #See comment on the Region parameter in the cloudformation stacks.

#CREATE OR UPDATE THE CLOUDFORMATION STACK OF THE AURORA CODEPIPELINE
aws cloudformation deploy --template-file ./Pipelines/Aurora-Postgres-Serverless-V2-CodePipeline.yaml --stack-name Aurora-Postgres-Serverless-V2-CodePipeline --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --parameter-overrides Environment=dev Region=us-east-1 #See comment on the Region parameter in the cloudformation stacks.

