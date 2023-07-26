# docker-letsencrypt

[![dokku/letsencrypt](http://dockeri.co/image/dokku/letsencrypt)](https://hub.docker.com/r/dokku/letsencrypt)

This is a containerfile for the **"simp_le"** Let's encrypt implementation by zenhack ([simp_le](https://github.com/zenhack/simp_le)). It's running on Alpine Linux and is only around 30MB in size.
It was inspired by `kuba/simp_le` and `katta/sim_le` but has a couple of improvements.

Certs are saved in `/certs` so you should mount a persistent volume there.

## Simple run

If you only want to get some certificates, simply run the container like this:

```shell
docker run -ti -p 80:80 -v /etc/nginx/certs:/certs \
    dokku/letsencrypt -f account_key.json -f account_reg.json  \
    -f chain.pem -f cert.pem -f key.pem --email a@example.org \
    -d adminswerk.de -d test.adminswerk.de
```

## Entrypoint Override

By default the container starts with an entrypoint-script which passes all arguments you start the container with to `simp_le.py`. If you want to start another application, e.g. for debugging or to build something ontop the container, you have to set the environment variable `OVERRIDE`. It only needs to be not null, the value doesn't matter.

```shell
docker run -ti -p 80:80 -v /etc/nginx/certs:/certs -e "OVERRIDE=1" dokku/letsencrypt sh
````
