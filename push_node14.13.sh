#!/bin/bash

# Exit on any error
set -e

docker build -t yarbala/php74-laravel-app-cli:node14.13 -f cli_node14.13.Dockerfile .

docker push yarbala/php74-laravel-app-cli:node14.13
