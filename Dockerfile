FROM node:18
LABEL maintainer="V2Fly Community"

WORKDIR /root
ARG TARGETPLATFORM
ARG TAG
COPY v2ray.sh /root/v2ray.sh

RUN set -ex \
    && apk update \
    && apk add --no-cache tzdata openssl ca-certificates curl \
    && mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/v2ray/access.log \
    && ln -sf /dev/stderr /var/log/v2ray/error.log \
    && chmod +x /root/v2ray.sh \
    && /root/v2ray.sh "linux/amd64" "v5.1.0"
