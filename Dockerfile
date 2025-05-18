# ---- Build Stage ----
FROM rust:1.87.0 AS builder
WORKDIR /usr/src/app
COPY . .
RUN cargo build --release

# ---- Runtime Stage ----
FROM debian:bookworm-slim  # << updated from buster
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/src/app/target/release/server /usr/local/bin/server

EXPOSE 8080
CMD ["server"]
