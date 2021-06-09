# Introduction
This is a simple means of building a Docker image that can be used for building infrastructure using Terraform and with tfsec too.

Please note this is just something I've hacked together, I am quite sure it'll need tweaking for real world usage!

# Build
To create the image, the following assumes bash, but that's mainly just to set an externalised variable with the version:
```bash
read BUILDER_VERSION
docker build --tag repo/something:${BUILDER_VERSION} --tag repo/something:latest --build-arg BUILDER_VERSION .
```

# Run Locally
To run `tfsec`, assumes the Terraform configuration is in `~/Development/Terraform`, and supplies the `terraform.tfvars` file as an example of additional parameters:
```bash
$ cd ~/Development/Terraform
$ docker run --rm --volume `pwd`:/tmp/$$ repo/something:latest /tmp/$$ --tfvars-file /tmp/$$/terraform.tfvars
```

# Pushing to AWS Elastic Container Registry
This is an example of pushing to a public repo, the specifics will need to be reviewed for your setup:
```bash
$ aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/deadbeef
$ docker tag repo:latest public.ecr.aws/deadbeef/repo:latest
$ docker push public.ecr.aws/deadbeef/repo:latest
```

For a private repo:
```bash
$ aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.region.amazonaws.com
$ docker tag repo/something:latest 123456789012.dkr.ecr.region.amazonaws.com/repo/something:latest
$ docker push 123456789012.dkr.ecr.region.amazonaws.com/repo/something:latest
```

# Links
- https://docs.docker.com/engine/reference/commandline/build/
- https://docs.docker.com/engine/reference/builder/
- https://learn.hashicorp.com/tutorials/terraform/automate-terraform
- https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html