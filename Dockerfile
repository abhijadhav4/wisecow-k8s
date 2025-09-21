# Use a small Debian base so fortune & cowsay are available
FROM debian:12-slim

# metadata
LABEL maintainer="chota_bheem <dholakpur@gmail.com>"
ENV SRVPORT=4499

# install runtime dependencies
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    netcat-openbsd \
    fortune-mod \
    cowsay \
 && rm -rf /var/lib/apt/lists/*

# add app
WORKDIR /app
COPY wisecow.sh /app/wisecow.sh
COPY LICENSE /app/LICENSE

RUN chmod +x /app/wisecow.sh

EXPOSE ${SRVPORT}

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
 CMD nc -z localhost ${SRVPORT} || exit 1

CMD ["/app/wisecow.sh"]
