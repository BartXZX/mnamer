#!/bin/sh

while true; do
    mnamer $MNAMER_SOURCE_DIR --config-path=$MNAMER_CONFIG_PATH

    echo "Waiting 55s for changes..."
    inotifywait -r -t 55 -e modify,create,move "$MNAMER_SOURCE_DIR"
    echo "Waiting an additional 5s to give additional file moves a chance to finish"
    sleep 5
done