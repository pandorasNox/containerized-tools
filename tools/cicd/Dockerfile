

FROM ubuntu:18.04


RUN apt-get update -y && \
    apt-get install -y \
        software-properties-common \
        python-pip \
        curl \
        rsync \
        git \
        gettext \
        gettext-base \
        nano dnsutils \
        iputils-ping \
        openssl \
        openssh-client \
        sshpass \
        make \
        bash-completion \
        apache2-utils \
        jq \
        bsdmainutils \
        bats \
        libmnl0 \
        dkms \
        && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# ansible
ENV ANSIBLE_VERSION 2.5.1
RUN pip install ansible==${ANSIBLE_VERSION}

# ansible lint
RUN pip install ansible-lint


# enable bash autocompletion
RUN echo . /etc/bash_completion >> /root/.bashrc

 
# kubectl
ENV KUBERNETES_VERSION v1.13.5
RUN curl -s -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl && \
	chmod +x /usr/local/bin/kubectl && \
	echo "source <(kubectl completion bash)" >> ~/.bashrc


# krew
RUN ( \
  set -x; cd "$(mktemp -d)" && \
  curl -fsSLO "https://storage.googleapis.com/krew/v0.2.1/krew.{tar.gz,yaml}" && \
  tar zxvf krew.tar.gz && \
  ./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" install --manifest=krew.yaml --archive=krew.tar.gz \
)
ENV PATH="/root/.krew/bin:$PATH"
RUN kubectl krew install get-all


# helm
RUN curl -L --fail -o helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.14.1-linux-amd64.tar.gz && \
    tar zxv -C /tmp -f helm.tar.gz && \
    rm -f helm.tar.gz && \
	mv /tmp/linux-amd64/helm /usr/local/bin/ && \
	mv /tmp/linux-amd64/tiller /usr/local/bin/ && \
	rm -rf /tmp/linux-amd64

# helm plugins
RUN helm init --client-only
RUN helm plugin install https://github.com/databus23/helm-diff --version 2.11.0+5

# helmfile
RUN curl -L --fail https://github.com/roboll/helmfile/releases/download/v0.77.0/helmfile_linux_amd64 -o /usr/local/bin/helmfile && \
	chmod +x /usr/local/bin/helmfile


ENV KUSTOMIZE_VERSION 2.1.0
RUN curl --fail -L https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 -o /usr/local/bin/kustomize \
 && chmod +x /usr/local/bin/kustomize


CMD ["bash"]

