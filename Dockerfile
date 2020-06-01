FROM alpine:3.12.0

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
    && apk --purge del musl-dev openssl-dev libffi-dev gcc python-dev py-pip \
    && wget https://dl.eff.org/certbot-auto \
    && sudo mv certbot-auto /usr/local/bin/certbot-auto \
    && sudo chown root /usr/local/bin/certbot-auto \
    && sudo chmod 0755 /usr/local/bin/certbot-auto
WORKDIR /certs
COPY ["./startme.sh", "/usr/local/bin/"]
ENTRYPOINT ["/usr/local/bin/startme.sh"]
