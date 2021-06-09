FROM alpine

#
# change the value to invalidate the layers below and force a rebuild...
#
ENV REFRESHED 2021-06-09

LABEL description="CodeBuild image with terraform & tfsec"
LABEL version="${BUILDER_VERSION}"

#
# start from a base of a selected terraform:light base image
#
FROM hashicorp/terraform:latest AS terraform

#
# add tfsec
#
FROM tfsec/tfsec:latest AS tfsec

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
