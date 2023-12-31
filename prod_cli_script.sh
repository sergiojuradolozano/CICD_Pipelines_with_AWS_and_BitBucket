#RUN THIS SCRIPT IN THE LOCATION WHERE THE FILES ARE IN.

#CREATE the S3 Bucket for the pipelines artifact
aws cloudformation deploy --template-file ./Pipelines/CodePipelineS3ArtifactsBucket.yaml --stack-name CodePipelineS3ArtifactsBucket --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --parameter-overrides Environment=prod Region=us-east-1 #See comment on the Region parameter in the cloudformation stacks.

#CREATE OR UPDATE THE CLOUDFORMATION STACK OF THE Pipelines Role
aws cloudformation deploy --template-file ./Pipelines-Role/CodePipelines-Role.yaml --stack-name CodePipelines-Role --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --parameter-overrides Environment=prod Region=us-east-1 #See comment on the Region parameter in the cloudformation stacks.

#CREATE OR UPDATE THE CLOUDFORMATION STACK OF THE CORE NETWORK PIPELINE
aws cloudformation deploy --template-file ./Pipelines/Core-Network-CodePipeline.yaml --stack-name Core-Network-CodePipeline --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --parameter-overrides Environment=prod Region=us-east-1 #See comment on the Region parameter in the cloudformation stacks.

#CREATE OR UPDATE THE CLOUDFORMATION STACK OF THE APPLICATION PIPELINE
aws cloudformation deploy --template-file ./Pipelines/Application-CodePipeline.yaml --stack-name Application-CodePipeline --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --parameter-overrides Environment=prod Region=us-east-1 #See comment on the Region parameter in the cloudformation stacks.

