FROM alpine:3.19

ARG GOMPLATE_VERSION=v3.11.7
ARG KUBECTL_VERSION=v1.31.3
ARG HELM_VERSION=v3.16.3
ARG TARGETARCH

RUN apk add --no-cache \
    bash \
    curl \
    ca-certificates \
    gettext \
    jq

RUN set -e; \
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl"; \
    chmod +x kubectl && mv kubectl /usr/local/bin/

RUN set -e; \
    curl -LO "https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz"; \
    tar -zxvf helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz; \
    mv linux-${TARGETARCH}/helm /usr/local/bin/helm; \
    chmod +x /usr/local/bin/helm; \
    rm -rf helm-*tar.gz linux-${TARGETARCH}

RUN curl -Lo /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/${GOMPLATE_VERSION}/gomplate_linux-${TARGETARCH} \
    && chmod +x /usr/local/bin/gomplate

ENTRYPOINT ["/bin/bash"]
