#!/bin/bash
docker run --rm -t -a stdout --name my-nginx -v $PWD/config/:/etc/nginx/:ro nginx:latest nginx -c /etc/nginx/nginx.conf -t