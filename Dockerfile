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

USER ubuntu
WORKDIR /home/ubuntu

CMD ["kubectl"]
