#RUN THIS SCRIPT IN THE LOCATION WHERE THE FILES ARE IN.

#CREATE OR UPDATE THE CLOUDFORMATION STACK OF THE AURORA CODEPIPELINE ROLE
aws cloudformation deploy --template-file ./Aurora-Postgres-Serverless-V2-CodePipeline-Role.yaml --stack-name Aurora-Postgres-Serverless-V2-CodePipeline-Role --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --parameter-overrides Environment=dev Region=us-east-1 #See comment on the Region parameter in the cloudformation stacks.

#CREATE OR UPDATE THE CLOUDFORMATION STACK OF THE AURORA CODEPIPELINE
aws cloudformation deploy --template-file ./Aurora-Postgres-Serverless-V2-CodePipeline.yaml --stack-name Aurora-Postgres-Serverless-V2-CodePipeline --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --parameter-overrides Environment=dev Region=us-east-1 #See comment on the Region parameter in the cloudformation stacks.

