## usage example

### example

docker run -it --rm hitian/ss ss-server -h

### run server with UDP relay & obfs

docker run -it -v `CONFIG_JSON_DIR`:/config --name ss-server --net=host -d hitian/ss ss-server -c /config/server.json -u --fast-open --plugin obfs-server --plugin-opts "obfs=http;fast-open"

### client

docker run -it -v `CONFIG_JSON_DIR`:/config --name ss-client -p `LOCAL_PORT`:`LOCAL_PORT` -d hitian/ss ss-local -c /config/client.json --plugin obfs-local --plugin-opts "obfs=http;fast-open;obfs-host=www.bing.com" -b 0.0.0.0


### for arm32 devices like raspberry pi or tinker board

docker run -it --rm hitian/ss-arm32 ss-local -h
