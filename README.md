# next-server

Creates a Docker container running a minimal Alpine 3.14 tftp server
that serves the latest netboot.xyz tftp boot disks for UEFI and
Legacy.

Run the container with real-time log output:

```
docker run -p 69:69/udp netbootxyz/next-server
```

To create container as a running service:
```
docker create \
    --name=next-server \
    --restart=always \
    -p 69:69/udp \
    netbootxyz/next-server

docker start next-server
```

To tail logs in realtime to view connections: 

```
docker logs <container_id> -f 
```
