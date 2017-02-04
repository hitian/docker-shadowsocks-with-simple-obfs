USAGE:

server: 

docker run -it -v `CONFIG_JSON_DIR`:/config --name ss-server -d `DOCKER_IMAGE_NAME` ss-server -c /config/server.json --fast-open --plugin obfs-server --plugin-opts "obfs=http"

client:

docker run -it -v `CONFIG_JSON_DIR`:/config --link tsss -p 1080:1080 -d `DOCKER_IMAGE_NAME` ss-local -c /config/client.json --plugin obfs-local --plugin-opts "obfs=http;obfs-host=www.bing.com" -b 0.0.0.0