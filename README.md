<h1 align="center">
  <br>
  <img src="https://github.com/home-anthill/docs/blob/master/icons/logo512.png?raw=true" alt="ks89/home-anthill" width="220">
  <br>
home-anthill
  <br>
sharded-mongodb-compose
</h1>


## :open_book: Documentation :open_book:

Take a look here [home-anthill/docs](https://github.com/home-anthill/docs).

**Custom version with a smaller number of replicas** of [THIS PROJECT](https://github.com/pkdone/sharded-mongodb-docker).

Compose project to build and run a MongoDB Sharded Cluster on a local workstation with each MongoDB component (`mongod`, `mongos`) running in a separate container.

The cluster consists of 6 containers:
- **Shard0**: 2-member replica set (`shard0-replica0`, `shard0-replica1`)
- **ConfigDB**: 2-member replica set (`configdb-replica0`, `configdb-replica1`)
- **Mongos routers**: 2 query routers (`mongos-router0` on host port 27017, `mongos-router1` on host port 27018)

All containers are visible to each other on the same internal network. Once running, the MongoDB cluster is accessible from your workstation via localhost ports 27017 & 27018, which connect to each of the two mongos processes, respectively.

### Prerequisites

* [Podman Desktop](https://podman-desktop.io/) and [podman-compose](https://github.com/containers/podman-compose) are installed on your workstation (suggested)
* Alternatively, [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/) can be used
* The [MongoDB Shell](https://docs.mongodb.com/mongodb-shell/install/) is already installed on your workstation (alternatively use [MongoDB Compass](https://docs.mongodb.com/compass/current/install/))

### Build, Run & Connect

1. Build and start all containers:

```bash
podman-compose up --build -d
```

Or with Docker Compose:

```bash
docker compose up --build -d
```

2. Connect to the running cluster and check its status:

```bash
mongosh --port 27017
```

```
sh.status()
```

Use port 27018 to connect to the second `mongos` endpoint.

### Tips

* Show running containers: `podman-compose ps` (or `docker compose ps`)
* Show logs: `podman-compose logs mongos-router0` (or `docker compose logs mongos-router0`)
* Stop and remove all containers: `podman-compose down` (or `docker compose down`)


## :fire: Releases :fire:

GitHub releases [HERE](https://github.com/home-anthill/sharded-mongodb-compose/releases)

Versions:

- 29/03/2026 - 1.0.0


## :sparkling_heart: A big thank you to :sparkling_heart:

##### the authors of the main icon of this project:

- <a href="https://www.freepik.com/free-vector/underground-ant-nest-with-red-ants_18582279.htm">Image by brgfx</a> from <a href="https://www.freepik.com/" title="Freepik">Freepik</a>


# :copyright: License :copyright:

The MIT License (MIT)

Copyright (c) 2021-2026 Stefano Cappa (Ks89)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

<br/>
