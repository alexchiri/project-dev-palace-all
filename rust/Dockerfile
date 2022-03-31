FROM basic:1

USER root

ENV RUST_VERSION="1.51.0"

# install rust
RUN cd /tmp && curl -LO "https://static.rust-lang.org/dist/rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
  && tar -xvzf "./rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
  && chmod +x ./rust-${RUST_VERSION}-x86_64-unknown-linux-gnu/install.sh && ./rust-${RUST_VERSION}-x86_64-unknown-linux-gnu/install.sh