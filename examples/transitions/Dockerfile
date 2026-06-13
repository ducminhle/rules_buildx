FROM debian:trixie

ARG DEBIAN_FRONTEND=noninteractive

RUN unset SOURCE_DATE_EPOCH \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/usr/bin/git"]
CMD ["--version"]
