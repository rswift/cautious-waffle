#
# some random commands that have proven useful
#

echo -n "hashicorp/terraform version: "
read TERRAFORM_VERSION

echo -n "tfsec/tfsec version: "
read TFSEC_VERSION

echo -n "build version: "
read BUILDER_VERSION

AWS_ACCOUNT_NUMBER=123456789012
PUBLIC_ECR=abcd1234
PRIVATE_ECR_REPO=builder
PRIVATE_ECR_REGION=eu-west-2

docker build --tag ${PRIVATE_ECR_REPO}:${BUILDER_VERSION} --build-arg BUILDER_VERSION --build-arg TERRAFORM_VERSION --build-arg TFSEC_VERSION --no-cache --pull .
docker inspect ${PRIVATE_ECR_REPO}:${BUILDER_VERSION}

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/${PUBLIC_ECR}
docker tag ${PRIVATE_ECR_REPO}:${BUILDER_VERSION} public.ecr.aws/${PUBLIC_ECR}/builder:${BUILDER_VERSION}
docker push public.ecr.aws/${PUBLIC_ECR}/${PRIVATE_ECR_REPO}:${BUILDER_VERSION}

docker scan --accept-license --dependency-tree --file Dockerfile public.ecr.aws/${PUBLIC_ECR}/${PRIVATE_ECR_REPO}:${BUILDER_VERSION}

aws ecr get-login-password --region ${PRIVATE_ECR_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_NUMBER}.dkr.ecr.${PRIVATE_ECR_REGION}.amazonaws.com
docker tag ${PRIVATE_ECR_REPO}:${BUILDER_VERSION} ${AWS_ACCOUNT_NUMBER}.dkr.ecr.${PRIVATE_ECR_REGION}.amazonaws.com/${PRIVATE_ECR_REPO}:${BUILDER_VERSION}
docker push ${AWS_ACCOUNT_NUMBER}.dkr.ecr.${PRIVATE_ECR_REGION}.amazonaws.com/${PRIVATE_ECR_REPO}:${BUILDER_VERSION}