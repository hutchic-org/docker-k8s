# docker-k8s

A bunch of k8s ecosystem utilities in a Docker container

- kubectx
- kubectl
- kubens
- helm
- kind
- docker
- a handful of krew plugins

```
docker run -it --rm -v ~/.kube/config:/home/ubuntu/.kube/config -v ~/.aws/:/home/ubuntu/.aws -v /var/run/docker.sock:/var/run/docker.sock hutchic/docker-k8s /bin/bash
```

Install as an alias

```
alias kind="docker run -it --rm -v ~/.kube/config:/home/ubuntu/.kube/config -v ~/.aws/:/home/ubuntu/.aws -v /var/run/docker.sock:/var/run/docker.sock hutchic/docker-k8s kind"
alias kubectl="docker run -it --rm -v ~/.kube/config:/home/ubuntu/.kube/config -v ~/.aws/:/home/ubuntu/.aws -v /var/run/docker.sock:/var/run/docker.sock hutchic/docker-k8s kubectl"
alias helm="docker run -it --rm -v ~/.kube/config:/home/ubuntu/.kube/config -v ~/.aws/:/home/ubuntu/.aws -v /var/run/docker.sock:/var/run/docker.sock hutchic/docker-k8s helm"
```
