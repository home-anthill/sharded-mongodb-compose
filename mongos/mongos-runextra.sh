#!/bin/sh

if [ -z "$SHARD_LIST" ]; then
    exit 0
fi

# Wait until mongos can return a connection
until /usr/bin/mongosh --quiet --eval 'db.getMongo()'; do
    sleep 1
done

sleep 1

# Split set of shard URLs text by ';' separator and add each shard
echo "$SHARD_LIST" | tr ';' '\n' | while read -r shard; do
    /usr/bin/mongosh --port 27017 <<EOF
        sh.addShard("${shard}");
EOF
done
