FROM ubuntu:focal@sha256:669e010b58baf5beb2836b253c1fd5768333f0d1dbcb834f7c07a4dc93f474be

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ca-certificates openssl wget curl unzip sudo adduser less git pkg-config \
    && groupadd --gid 1000 ubuntu \
    && useradd --uid 1000 --gid 1000 -m ubuntu \
    && echo ubuntu ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu

RUN wget https://storage.googleapis.com/kubernetes-release/release/$(wget https://storage.googleapis.com/kubernetes-release/release/stable.txt -q -O -)/bin/linux/amd64/kubectl -q -O /usr/local/bin/kubectl \
    && chmod a+x /usr/local/bin/kubectl \
    && mkdir /home/ubuntu/.kube \
    && chmod g+rwX /home/ubuntu/.kube \
    && kubectl

RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -q -O awscliv2.zip \
    && unzip awscliv2.zip \
    && ./aws/install \
    && aws --version

RUN wget https://get.helm.sh/helm-canary-linux-amd64.tar.gz -q -O helm.tar.gz \
    && tar -xzvf helm.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && helm version

RUN wget https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz -q -O krew.tar.gz \
    && tar -xzvf krew.tar.gz

USER ubuntu
WORKDIR /home/ubuntu

RUN /krew-linux_amd64 install krew \
    && echo 'export PATH="$HOME/.krew/bin:$PATH"' >> ~/.bashrc \
    && export PATH="$HOME/.krew/bin:$PATH" \
    && kubectl krew update \
    && kubectl krew install exec-as modify-secret view-secret whoami

CMD ["kubectl"]
