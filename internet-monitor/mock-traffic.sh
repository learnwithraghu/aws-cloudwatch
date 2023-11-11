#!/bin/bash

ENDPOINT="<Replace with public URL of the flask app>"
MAX_CALLS=2000

for ((i=1; i<=MAX_CALLS; i++)); do
    curl "$ENDPOINT"
    echo "Request $i sent"
    if [[ $i -ne $MAX_CALLS ]]; then
        sleep 2
    fi
done