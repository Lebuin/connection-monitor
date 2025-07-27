#!/bin/bash

# Status 0: host is reachable
# Status 1: host is unreachable
send_status () {
  status=$1
  wget -q -O - $HEALTHCHECK_URL/$status
  echo
}

while true; do
  echo "Checking connectivity to $HOST..."

  if ping -c 1 -W 5 "$HOST" > /dev/null 2>&1; then
    status=0
    echo "Host $HOST is reachable"
  else
    status=1
    echo "Host $HOST is unreachable"
  fi

  send_status $status;

  sleep $INTERVAL
done
