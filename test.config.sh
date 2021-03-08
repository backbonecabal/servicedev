#!/bin/bash
# SPDX-license-idnetifier: ISC
# Smoke Test Nginx Configuration

rootPath=$1
nginxVersion=1.13  # Could also be passed as an argument using $2

result=$(docker run --rm -t -a stdout --name my-nginx -v "${rootPath}"/config/:/etc/nginx/:ro nginx:$nginxVersion nginx -c /etc/nginx/nginx.conf -t)

#  @dev this loosk for the word successful and count the lines that have it
successful=$(echo "$result" | grep successful -c )

if [ "$successful" = 0 ]; then
    echo FAILED
    echo "$result"
    exit 1
else
    echo SUCCESS
fi