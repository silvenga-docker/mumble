FROM alpine:3.6

LABEL matainer="Mark Lopez <m@silvenga.com>"

ARG MUMBLE_VERSION=1.2.19-r1

RUN set -ex \
    && apk add --no-cache python \
    && apk add --no-cache "icu-libs=58.2-r2" "murmur=${MUMBLE_VERSION}" \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing py-iniparse \
    && apk add --no-cache --virtual .build curl \
    && curl -o /usr/bin/crudini https://raw.githubusercontent.com/pixelb/crudini/d89188d3f773dd671e31b8e4d222fcdd98ca1f47/crudini \
    && chmod +x /usr/bin/crudini \
    && apk del .build

COPY files/init.sh /init.sh

EXPOSE 64738
VOLUME [ "/data" ]

CMD ["/bin/sh", "/init.sh"]