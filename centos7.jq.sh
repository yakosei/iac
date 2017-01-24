#!/bin/bash
curl -kLR https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -o /tmp/jq
chmod 755 /tmp/jq
\mv /tmp/jq /usr/bin
