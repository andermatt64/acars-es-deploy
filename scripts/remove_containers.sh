#/bin/bash

for id in $(docker ps -a --filter "name=acars_" -q); do
  docker rm $id >/dev/null
done
  
