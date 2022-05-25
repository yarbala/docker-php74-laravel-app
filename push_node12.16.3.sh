#!/bin/bash

# Exit on any error
set -e

docker build -t yarbala/php74-laravel-app-cli:node12.16.3 -f cli_node12.16.3.Dockerfile .

docker push yarbala/php74-laravel-app-cli:node12.16.3
