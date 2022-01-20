FROM rust:slim as builder
WORKDIR /build
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        musl-tools make git clang \
    && rm -rf /var/lib/apt/lists/*

COPY packetcrypt_rs/ .

RUN cargo clean

# RUN CC=clang cargo build --release
RUN PC_CC=clang cargo build --release --features portable

FROM debian:bullseye-slim as prod

WORKDIR /packetcrypt

RUN useradd miner
USER miner
COPY --from=builder --chmod=771 /build/target/release/packetcrypt .

ENTRYPOINT [ "./packetcrypt" ]
