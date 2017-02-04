## usage example

### example

docker run -it --rm hitian/docker-shadowsocks-with-simple-obfs ss-server -h

### run server with UDP relay & obfs

docker run -it -v `CONFIG_JSON_DIR`:/config --name ss-server -p `SERVER_PORT`:`SERVER_PORT` -p `SERVER_PORT`:`SERVER_PORT`/udp -d hitian/docker-shadowsocks-with-simple-obfs ss-server -c /config/server.json -u --fast-open --plugin obfs-server --plugin-opts "obfs=http"

### client

docker run -it -v `CONFIG_JSON_DIR`:/config --name ss-client -p `LOCAL_PORT`:`LOCAL_PORT` -d hitian/docker-shadowsocks-with-simple-obfs ss-local -c /config/client.json --plugin obfs-local --plugin-opts "obfs=http;obfs-host=www.bing.com" -b 0.0.0.0


## Raspberry Pi armhf

replace `FROM ubuntu:latest` with `FROM armhf/ubuntu:latest` and build.

OR 

`docker pull hitian/docker-armhf-shadowsocks-with-simple-obfs`

