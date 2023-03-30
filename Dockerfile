FROM alpine:3.17.3


# hadolint ignore=DL3018
RUN apk --no-cache add python3 \
        python3-dev \
        py3-setuptools \
        py3-cryptography \
        py3-pip \
        certbot \
        darkhttpd \
        gcc \
        git \
        libffi-dev \
        musl-dev \
        openssl \
        openssl-dev \
        && git clone --single-branch --branch 0.18.1 https://github.com/zenhack/simp_le.git /simp_le \
        && pip --no-cache-dir install -e /simp_le/ \
        && mkdir /certs \
        && apk --purge del musl-dev openssl-dev libffi-dev gcc python3-dev py3-pip

WORKDIR /certs
COPY ["./startme.sh", "/usr/local/bin/"]
ENTRYPOINT ["/usr/local/bin/startme.sh"]
