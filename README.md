# Introduction
This is a simple means of building a Docker image that can be used for building infrastructure using Terraform and with tfsec too.

Please note this is just something I've hacked together, I am quite sure it'll need tweaking for real world usage!

# Build
There is a [file](./build.sh "build.sh") that has some commands in covering image build, tagging and upload to ECR (public and private repo).

# In use
The [Example Terraform](./Example-Terraform "Example Terraform") directory contains a trivial Terraform config and a [buildspec.yml](./Example-Terraform/buildspec.yml "buildspec.yml") file for the CodeBuild project.

Relevant IAM policies will need to be attached to the CodeBuild service role, not only for the ECR pull, but S3 (for the state) and in this example, `logs:...` too.

# Links
- https://docs.docker.com/engine/reference/commandline/build/
- https://docs.docker.com/engine/reference/builder/
- https://learn.hashicorp.com/tutorials/terraform/automate-terraform
- https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html