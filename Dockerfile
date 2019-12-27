FROM alpine:3.11.2

MAINTAINER Jose Diaz-Gonzalez <dokku@josediazgonzalez.com>

# Long command to keep the FS deltas small
RUN apk --update add python \
        python-dev \
        py-setuptools \
        py-pip \
        openssl-dev \
        openssl \
        musl-dev \
        gcc \
        libffi-dev \
        git \
        darkhttpd \
    && git clone --single-branch --branch 0.15.0 https://github.com/zenhack/simp_le.git /simp_le \
    && pip install -e /simp_le/ \
    && mkdir /certs \
    && apk --purge del musl-dev openssl-dev libffi-dev gcc python-dev py-pip
WORKDIR /certs
COPY ["./startme.sh", "/usr/local/bin/"]
ENTRYPOINT ["/usr/local/bin/startme.sh"]
