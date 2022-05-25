#!/bin/bash

# Exit on any error
set -e

docker build -t yarbala/php74-laravel-app-front:latest -t yarbala/php74-laravel-app-front:v1.1.5 -f front.Dockerfile .
docker build -t yarbala/php74-laravel-app-cli:latest -t yarbala/php74-laravel-app-cli:v1.1.5 -f cli.Dockerfile .

docker push yarbala/php74-laravel-app-front:v1.1.5
docker push yarbala/php74-laravel-app-cli:v1.1.5
