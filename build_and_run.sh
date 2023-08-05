#!/bin/bash

docker build . -t grafana-livecamera &&
docker run --network host --name=grafana \
  --volume grafana-storage:/var/lib/grafana \
  -e "GF_PANELS_DISABLE_SANITIZE_HTML=true" \
  grafana-livecamera
