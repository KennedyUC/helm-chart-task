FROM ubuntu:20.04

# Install the necessary Ubuntu utils
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y sudo && \
    apt-get install -y curl

# Install Git
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

# Installing helm cli
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

# install helm cm-push plugin
RUN helm plugin install https://github.com/chartmuseum/helm-push