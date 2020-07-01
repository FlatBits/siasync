# build siasync
FROM ubuntu:20.04 AS builder

ARG GO_VERSION=1.14.4

RUN echo "Installing apt dependencies" && apt-get update && apt-get install -y curl git build-essential

RUN echo "Installing golang ${GO_VERSION}" && curl -sSL https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xz

ENV PATH=$PATH:/usr/local/go/bin

RUN echo "Clone Siasync Repo" && git clone https://github.com/tbenz9/siasync.git /app

WORKDIR /app

RUN echo "Build Siasync" && make dependencies && make

# run siasync
FROM ubuntu:20.04

ENV PATH /opt/siasync/bin:$PATH

ENV SIA_API_ADDRESS "127.0.0.1:9980"
# SIA_API_PASSWORD to specify password
ENV SIA_API_AGENT "Sia-Agent"

ENV SIASYNC_ARCHIVE false
ENV SIASYNC_DEBUG false
ENV SIASYNC_SUBFOLDER "siasync"
ENV SIASYNC_INCLUDE ""
ENV SIASYNC_INCLUDE_HIDDEN false
ENV SIASYNC_EXCLUDE ""
ENV SIASYNC_DATA_PIECES 10
ENV SIASYNC_PARITY_PIECES 30
ENV SIASYNC_SIZE_ONLY false
ENV SIASYNC_SYNC_ONLY false
ENV SIASYNC_DRY_RUN false

COPY --from=builder /app/siasync /opt/siasync/bin/siasync
COPY scripts /scripts

WORKDIR /opt/siasync

ENTRYPOINT ["/scripts/init.sh"]
