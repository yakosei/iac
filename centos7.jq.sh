#!/bin/bash
curl -kLR https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -o jq
chmod 755 jq
\mv jq /usr/bin
