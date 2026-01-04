#!/bin/sh

echo "Executing mnamer"
mnamer $MNAMER_SOURCE_DIR --config-path=$MNAMER_CONFIG_PATH

inotifywait -mre create,modify,move $MNAMER_SOURCE_DIR | while read -r dirname events basename;
do
  echo "New events received, collecting more for 5s"
  echo "$dirname $events $basename"

  # Consume all events that happen within the next seconds
  while read -t 5 -r next_event; do
    echo $next_event
  done

  mnamer $MNAMER_SOURCE_DIR --config-path=$MNAMER_CONFIG_PATH
done