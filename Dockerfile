FROM alpine:3.10.0

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
    && git clone https://github.com/zenhack/simp_le.git /simp_le-master \
    && pip install -e /simp_le-master/ \
    && mkdir /certs \
    && apk --purge del musl-dev openssl-dev libffi-dev gcc python-dev py-pip
WORKDIR /certs
COPY ["./startme.sh", "/usr/local/bin/"]
ENTRYPOINT ["/usr/local/bin/startme.sh"]
