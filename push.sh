#!/bin/bash

#docker build -t yarbala/php74-laravel-app-front:latest -t yarbala/php74-laravel-app-front:v1.0.0 -f front.Dockerfile .
docker build -t yarbala/php74-laravel-app-cli:latest -t yarbala/php74-laravel-app-cli:v1.0.1 -f cli.Dockerfile .

#docker push yarbala/php74-laravel-app-front:v1.0.0
docker push yarbala/php74-laravel-app-cli:v1.0.1
