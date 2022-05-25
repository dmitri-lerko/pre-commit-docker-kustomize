FROM alpine:latest
RUN adduser kustomize -D \
  && apk add curl git openssh \
  && git config --global url.ssh://git@github.com/.insteadOf https://github.com/
RUN  curl -L --output /tmp/kustomize_v4.5.5_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.5.5/kustomize_v4.5.5_linux_amd64.tar.gz \
  && echo "bba81aa61dba057db1d5abeddf1e522b568b2d906ab67a5c80935e97302c8773  /tmp/kustomize_v4.5.5_linux_amd64.tar.gz" | sha256sum -c \
  && tar -xvzf /tmp/kustomize_v4.5.5_linux_amd64.tar.gz -C /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && mkdir ~/.ssh \
  && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
USER kustomize
WORKDIR /src
