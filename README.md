# Nginx with geoIP support

Dockerfile with Nginx v.1.19.10 with geoIP module.
At config file `config/proxy.conf` you can see exaple of usage.

It works with `jwilder/nginx-proxy` and `letsencrypt`

# Instalation

1. Change paths to your services at `proxy.conf`
2. Download free country GeoLite2 database are available from [Maxminds website](https://dev.maxmind.com/geoip/geolite2-free-geolocation-data) (requires signing up) and put it in db directory. Dockerfile at build will copy DB to right directory.
3. Spinup container or use it with docker-compose.
