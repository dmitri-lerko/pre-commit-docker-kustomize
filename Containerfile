FROM alpine:latest

LABEL org.opencontainers.image.source = "https://github.com/b4mad/pre-commit-kustomize"

RUN adduser kustomize -D \
  && apk add curl git openssh \
  && git config --global url.ssh://git@github.com/.insteadOf https://github.com/
RUN  curl -L --output /tmp/kustomize_v5.0.3_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.0.3/kustomize_v5.0.3_linux_amd64.tar.gz \
  && echo "c627b1575c3fecbc7ad1c181c23a7adcacf19732dab627eb57e89a7bc4c1e929  /tmp/kustomize_v5.0.3_linux_amd64.tar.gz" | sha256sum -c \
  && tar -xvzf /tmp/kustomize_v5.0.3_linux_amd64.tar.gz -C /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && mkdir ~/.ssh \
  && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

USER kustomize

WORKDIR /src
