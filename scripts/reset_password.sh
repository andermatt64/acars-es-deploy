#!/bin/bash

# Run it to get rid of some warning messages
docker exec -it acars_es bin/elasticsearch-reset-password -u elastic -b -s 2>&1 > /dev/null

ES_AUTH_PATH_INFO=$1
ELASTIC_PASSWORD=$(docker exec -it acars_es bin/elasticsearch-reset-password -u elastic -b -s 2> /dev/null) 
KIBANA_PASSWORD=$(docker exec -it acars_es bin/elasticsearch-reset-password -u kibana_system -b -s 2> /dev/null)

printf "# ElasticSearch Authentication Info\n\n" > ${ES_AUTH_PATH_INFO}
printf "| Username        | Password               |\n" >> ${ES_AUTH_PATH_INFO}
printf "| --------------- | ---------------------- |\n" >> ${ES_AUTH_PATH_INFO}
printf "| \`elastic\`       | \`${ELASTIC_PASSWORD//$'\r'}\` |\n" >> ${ES_AUTH_PATH_INFO}
printf "| \`kibana_system\` | \`${KIBANA_PASSWORD//$'\r'}\` |\n" >> ${ES_AUTH_PATH_INFO}
