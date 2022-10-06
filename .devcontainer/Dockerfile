FROM eu.gcr.io/cts-public-images-1/cts-standard:latest

# Amend TF version if required
ARG TERRAFORM_VERSION=1.2.4

ARG ZSH_SUGGESTIONS_REPO=https://github.com/zsh-users/zsh-autosuggestions
ARG ZSH_HIGHLIGHTING_REPO=https://github.com/zsh-users/zsh-syntax-highlighting.git
ARG GO_VERSION=1.18.2
ARG VAULT_VERSION=1.10.0-rc1

# Amend TG version if required
ARG TERRAGRUNT_VERSION=0.38.5

ARG KUBECTL_VER=v1.20.0
ARG KUSTOMIZE_VERSION=4.2.0

ARG EXECUTABLES_PATH=/usr/local/bin
ARG USERNAME=vscode
ARG HOME=/home/vscode

RUN apt update && export DEBIAN_FRONTEND=noninteractive && \
  apt upgrade -y && \
  apt -y install --no-install-recommends \
  vim \
  zsh \
  fzf \
  && apt clean -y && rm -rf /var/lib/apt/lists/*

# Install terraform
RUN curl -SOL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_$(dpkg --print-architecture).zip && \
  unzip terraform_${TERRAFORM_VERSION}_linux_$(dpkg --print-architecture).zip && \
  install terraform ${EXECUTABLES_PATH} && \
  rm -rf terraform*

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VER}/bin/linux/$(dpkg --print-architecture)/kubectl && \
  chmod +x kubectl && \
  mv kubectl ${EXECUTABLES_PATH}

# Install Kustomize
RUN curl -sLO  https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_$(dpkg --print-architecture).tar.gz && \
  tar -zxvf kustomize_v${KUSTOMIZE_VERSION}_linux_$(dpkg --print-architecture).tar.gz && \
  chmod +x kustomize && \
  mv kustomize ${EXECUTABLES_PATH}

# Install Go
RUN wget -c https://go.dev/dl/go${GO_VERSION}.linux-$(dpkg --print-architecture).tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-$(dpkg --print-architecture).tar.gz && \
    rm -f https://go.dev/dl/go${GO_VERSION}.linux-$(dpkg --print-architecture).tar.gz

# Add Go to Path
ENV PATH=${PATH}:/usr/local/go/bin

# Install Vault
RUN curl https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_$(dpkg --print-architecture).zip > vault_${VAULT_VERSION}_linux_$(dpkg --print-architecture).zip && \
  unzip vault_${VAULT_VERSION}_linux_$(dpkg --print-architecture).zip -d ${EXECUTABLES_PATH} && \
  rm -d vault_${VAULT_VERSION}_linux_$(dpkg --print-architecture).zip

# Install terragrunt
RUN curl -SL -o terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_$(dpkg --print-architecture) && \
  install terragrunt ${EXECUTABLES_PATH} && \
  rm terragrunt

# Install zsh syntax highlighting and auto-completion
RUN git clone ${ZSH_SUGGESTIONS_REPO} /home/vscode/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone ${ZSH_HIGHLIGHTING_REPO} /home/vscode/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

RUN sed -i "s/plugins=(git)/plugins=(git kubectl terraform zsh-autosuggestions zsh-syntax-highlighting)/g" /home/vscode/.zshrc

# Set ZSH
ENV SHELL=/usr/bin/zsh

# Set TG cache
ENV TERRAGRUNT_DOWNLOAD=${HOME}/.terragrunt-cache
ENV TF_PLUGIN_CACHE_DIR=${TERRAGRUNT_DOWNLOAD}/.plugins
