#!/bin/bash

docker build . -t grafana-livecamera &&
docker run -d -p 3000:3000 --name=grafana \
  --volume grafana-storage:/var/lib/grafana \
  -e "GF_PANELS_DISABLE_SANITIZE_HTML=true" \
  grafana-livecamera
