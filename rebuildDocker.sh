#!/bin/bash
export $(grep -v '^#' .env | xargs)
docker compose -f docker-compose.${APP_ENV}.yml stop
docker compose -f docker-compose.${APP_ENV}.yml build
docker compose -f docker-compose.${APP_ENV}.yml up --build -d
