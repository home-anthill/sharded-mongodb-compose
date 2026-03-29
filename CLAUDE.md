# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Docker Compose project (part of the [home-anthill](https://github.com/home-anthill) ecosystem) that deploys a MongoDB Sharded Cluster locally. This is a **custom fork** of [pkdone/sharded-mongodb-docker](https://github.com/pkdone/sharded-mongodb-docker) **with reduced replica counts** (2 replicas per set instead of 3). The project was renamed from `sharded-mongodb-docker` to `sharded-mongodb-compose` to better reflect its nature as a Compose-based deployment.

The cluster consists of 6 containers:
- **Shard0**: 2-member replica set (`shard0-replica0`, `shard0-replica1`)
- **ConfigDB**: 2-member replica set (`configdb-replica0`, `configdb-replica1`)
- **Mongos routers**: 2 query routers (`mongos-router0` on host port 27017, `mongos-router1` on host port 27018)

## Commands

Podman is the suggested container runtime, but Docker works as well.

```bash
# Build and start the cluster
podman-compose up --build -d    # or: docker compose up --build -d

# Stop and remove all containers
podman-compose down              # or: docker compose down

# Check running containers
podman-compose ps                # or: docker compose ps

# View logs for a specific container
podman-compose logs mongos-router0  # or: docker compose logs mongos-router0

# Connect to the cluster via mongosh
mongosh --port 27017
```

## Architecture

### Container Startup Flow

Each container uses a two-phase entrypoint pattern. All scripts are POSIX `/bin/sh` (not bash).

1. **`*-start.sh`** (entrypoint): Forks a background `*-runextra.sh` script, then `exec`s Docker's official `docker-entrypoint.sh`.
2. **`*-runextra.sh`** (background init):
   - **mongod**: If `DO_INIT_REPSET=true`, waits for mongod to be ready, then calls `rs.initiate()` to bootstrap the replica set. Only `replica0` of each set has this flag.
   - **mongos**: Exits immediately if `SHARD_LIST` is unset. Otherwise, waits for mongos to be ready, then calls `sh.addShard()` for each shard in `SHARD_LIST` (semicolon-delimited). Only `mongos-router0` has `SHARD_LIST` set.

### Key Environment Variables (set in docker-compose.yml)

- `REPSET_NAME`: Replica set name used by `mongod-runextra.sh` for `rs.initiate()`
- `DO_INIT_REPSET`: When `true`, triggers replica set initialization on that container
- `SHARD_LIST`: Semicolon-delimited shard connection strings consumed by `mongos-runextra.sh`

### Networking

All containers share the `internalnetwork` Docker network. Container hostnames match their service names (e.g., `shard0-replica0`). Only mongos routers expose ports to the host, bound to `127.0.0.1` (localhost only, not accessible from LAN).

### Security

This cluster is intended for **local development only** and has no authentication or TLS enabled. The mongos router ports are bound to `127.0.0.1` to prevent exposure to the local network.
