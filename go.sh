#!/bin/bash
docker rm -f next-server-dev
docker rmi -f next-server-dev
docker build . -t next-server-dev
docker run -d -it --name=next-server-dev --restart=always -p 69:69/udp -p 8080:80 next-server-dev
