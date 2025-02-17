FROM alpine:3.21

# Install necessary packages and create directories
RUN mkdir -p /httpboot/ipxe && \
    apk --update add --no-cache tftp-hpa busybox nginx envsubst && \
    # Download boot files
    wget -P /httpboot https://boot.ipxe.org/ipxe.efi && \
    wget -P /httpboot https://boot.ipxe.org/ipxe.pxe && \
    wget -P /httpboot https://boot.ipxe.org/undionly.kpxe && \
    wget -P /httpboot https://boot.ipxe.org/snponly.efi && \
    wget -P /httpboot https://github.com/ipxe/wimboot/releases/latest/download/wimboot && \
    wget -P /httpboot https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe && \
    wget -P /httpboot https://boot.netboot.xyz/ipxe/netboot.xyz-undionly.kpxe && \
    wget -P /httpboot https://boot.netboot.xyz/ipxe/netboot.xyz.efi && \
    wget -P /httpboot https://boot.netboot.xyz/ipxe/netboot.xyz-snp.efi && \
    wget -P /httpboot https://boot.netboot.xyz/ipxe/netboot.xyz-snponly.efi && \
    wget -P /httpboot https://boot.netboot.xyz/ipxe/netboot.xyz-arm64.efi && \
    wget -P /httpboot https://boot.netboot.xyz/ipxe/netboot.xyz-arm64-snp.efi && \
    wget -P /httpboot https://boot.netboot.xyz/ipxe/netboot.xyz-arm64-snponly.efi && \
    # Set permissions
    find /httpboot -type f -exec chmod 0444 {} +

# Set default environment variables for ports
ENV TFTP_PORT=69
ENV HTTP_PORT=80

# Expose ports
EXPOSE 69/udp
EXPOSE 80

# Copy scripts and configuration files
COPY entrypoint.sh /entrypoint.sh
COPY generate_index.sh /generate_index.sh
COPY nginx.conf /etc/nginx/nginx.conf

# Make scripts executable
RUN chmod +x /entrypoint.sh /generate_index.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
