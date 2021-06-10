#
# loads of ARG entries to pull through the layers
# https://docs.docker.com/engine/reference/builder/#scope
#
ARG TERRAFORM_VERSION
ARG TFSEC_VERSION
ARG BUILDER_VERSION

#
# start from a base of a selected terraform:light base image
#
FROM hashicorp/terraform:${TERRAFORM_VERSION} AS terraform
ARG TERRAFORM_VERSION
ARG TFSEC_VERSION
ARG BUILDER_VERSION

#
# add tfsec
#
FROM tfsec/tfsec:${TFSEC_VERSION} AS tfsec
ARG TERRAFORM_VERSION
ARG TFSEC_VERSION
ARG BUILDER_VERSION

WORKDIR /
USER root
COPY --from=terraform /bin/terraform /usr/local/bin/terraform
RUN cp /usr/bin/tfsec /usr/local/bin/tfsec

#
# edit provider.tf to include the providers to pre-cache to avoid
# the need download every time...
#
COPY provider.tf provider.tf
RUN terraform init

#
# change the value to invalidate the layers below and force a rebuild...
# the ARG pull through is just for this ¯\_(ツ)_/¯
#
LABEL description="CodeBuild image with terraform:${TERRAFORM_VERSION} & tfsec:${TFSEC_VERSION}"
LABEL version="${BUILDER_VERSION}"
