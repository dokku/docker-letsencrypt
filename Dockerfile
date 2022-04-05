FROM alpine:3.15.4

MAINTAINER Jose Diaz-Gonzalez <dokku@josediazgonzalez.com>

# Long command to keep the FS deltas small
RUN apk --update add python3 \
        python3-dev \
        py3-setuptools \
        py3-cryptography \
        py3-pip \
        darkhttpd \
        gcc \
        git \
        libffi-dev \
        musl-dev \
        openssl \
        openssl-dev \
        sudo \
    && git clone --single-branch --branch 0.18.1 https://github.com/zenhack/simp_le.git /simp_le \
    && pip3 install -e /simp_le/ \
    && mkdir /certs \
    && apk --purge del musl-dev openssl-dev libffi-dev gcc python3-dev py3-pip \
    && wget https://dl.eff.org/certbot-auto \
    && sudo mv certbot-auto /usr/local/bin/certbot-auto \
    && sudo chown root /usr/local/bin/certbot-auto \
    && sudo chmod 0755 /usr/local/bin/certbot-auto
WORKDIR /certs
COPY ["./startme.sh", "/usr/local/bin/"]
ENTRYPOINT ["/usr/local/bin/startme.sh"]
