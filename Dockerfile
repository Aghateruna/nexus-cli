FROM rust:1.76-slim as builder
WORKDIR /app

RUN apt-get update && apt-get install -y pkg-config libssl-dev build-essential

COPY . .

WORKDIR /app/clients/cli
RUN cargo build --release

FROM debian:bullseye-slim
WORKDIR /app
COPY --from=builder /app/clients/cli/target/release/nexus-cli .

ENV NODE_ID=6844097

CMD ["./nexus-cli", "run", "--node-id", "${NODE_ID}"]
