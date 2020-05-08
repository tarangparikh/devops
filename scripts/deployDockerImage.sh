#!/bin/bash 
docker stop calculator || true && docker rm calculator || true
docker container run --detach -p 80:8080 tarangparikh/calculator
