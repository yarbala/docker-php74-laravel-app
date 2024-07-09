#!/bin/bash

# Exit on any error
set -e

docker build --no-cache -t yarbala/php74-laravel-app-cli:node16.16 -f cli_node16.16.Dockerfile .

docker push yarbala/php74-laravel-app-cli:node16.16
