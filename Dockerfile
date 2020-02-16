FROM alpine:latest
RUN adduser kustomize -D \
  && apk add curl git openssh \
  && git config --global url.ssh://git@github.com/.insteadOf https://github.com/
RUN  curl -L --output /tmp/kustomize_v3.3.0_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.3.0/kustomize_v3.3.0_linux_amd64.tar.gz \
  && echo "4b49e1bbdb09851f11bb81081bfffddc7d4ad5f99b4be7ef378f6e3cf98d42b6  /tmp/kustomize_v3.3.0_linux_amd64.tar.gz" | sha256sum -c \
  && tar -xvzf /tmp/kustomize_v3.3.0_linux_amd64.tar.gz -C /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && mkdir ~/.ssh \
  && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
USER kustomize
WORKDIR /src
