# ---- Build Stage ----
FROM rust:1.75 AS builder
WORKDIR /usr/src/app
COPY . .
RUN cargo build --release

# ---- Runtime Stage ----
FROM debian:buster-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/src/app/target/release/my-actix-app /usr/local/bin/my-actix-app

# Expose port (use the same as in your Actix server)
EXPOSE 8080

CMD ["my-actix-app"]
