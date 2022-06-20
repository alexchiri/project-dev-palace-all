FROM basic:1

USER alex

ENV RUST_VERSION="1.51.0"

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain $RUST_VERSION