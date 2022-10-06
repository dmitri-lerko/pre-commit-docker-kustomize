FROM alpine:latest

ENV KUSTOMIZE_VERSION=v4.5.7
ENV KUSTOMIZE_CHECKSUM="701e3c4bfa14e4c520d481fdf7131f902531bfc002cb5062dcf31263a09c70c9"

RUN adduser kustomize -D \
  && apk add curl git openssh \
  && git config --global url.ssh://git@github.com/.insteadOf https://github.com/
RUN  curl -L --output /tmp/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
  && echo "${KUSTOMIZE_CHECKSUM}  /tmp/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" | sha256sum -c \
  && tar -xvzf /tmp/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz -C /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && mkdir ~/.ssh \
  && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
USER kustomize
WORKDIR /src