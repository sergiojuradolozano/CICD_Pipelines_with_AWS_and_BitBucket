Steps to build and upload a docker image to ECR.

# Build the docker image with the name welcome-app
docker build -t docker build -t welcome-app:1.0 .

# Tag the current version as the latest
docker tag welcome-app:1.0 welcome-app:latest

# Running it in port 3000. This serves as a test. The -rm will remove the container after it stops
docker run -it -p 3000:3000 --rm welcome-app:latest

# Create the repository in AWS ECR
aws ecr create-repository --repository-name welcome-app

# Copy the repository uri
aws ecr describe-repositories --repository-name welcome-app

# Login into the repository
aws ecr get-login-password --region {AWS region} | docker login --username AWS --password-stdin
{AWS Account id}.dkr.ecr.{AWS region}.amazonaws.com

# Append the repository Uri with the image tag
docker tag welcome-app {AWS Account id}.dkr.ecr.{AWS region}.amazonaws.com/welcome-app

# Push the image to the repository
docker push 101391583334.dkr.ecr.us-east-1.amazonaws.com/welcome-app