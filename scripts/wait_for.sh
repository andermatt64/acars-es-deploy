#!/bin/bash

HTTP_URL=$1

printf "Waiting for server to start up..."
until curl -s -I ${HTTP_URL} > /dev/null; do sleep 10; done 
printf "Done\n"