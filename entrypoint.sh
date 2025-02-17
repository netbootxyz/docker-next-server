#!/bin/sh

# Print ASCII logo to logs
echo "Loading netboot.xyz next-server container..."
echo
echo "            _   _                 _                      "
echo " _ __   ___| |_| |__   ___   ___ | |_  __  ___   _ ____  "
echo "| '_ \ / _ \ __| '_ \ / _ \ / _ \| __| \ \/ / | | |_  /  "
echo "| | | |  __/ |_| |_) | (_) | (_) | |_ _ >  <| |_| |/ /   "
echo "|_| |_|\___|\__|_.__/ \___/ \___/ \__(_)_/\_\\__,  /___| "
echo "                                             |___/       "
echo
echo "If you enjoy netboot.xyz projects, please support us at:"
echo
echo "https://opencollective.com/netbootxyz"
echo "https://github.com/sponsors/netbootxyz"
echo
echo Source: https://github.com/netbootxyz/docker-next-server
echo

# Generate index.html
./generate_index.sh

# Start syslog
busybox syslogd -n -O /dev/stdout &

# Start TFTP server with logging to stdout
in.tftpd -Lvvv --address :${TFTP_PORT} --ipv4 --secure -u nobody /httpboot 2>&1 &

# Replace environment variables in nginx configuration
HTTP_PORT=${HTTP_PORT:-80}
export HTTP_PORT
envsubst '${HTTP_PORT}' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf.tmp && mv /etc/nginx/nginx.conf.tmp /etc/nginx/nginx.conf

# Start nginx
nginx -g 'daemon off;'
