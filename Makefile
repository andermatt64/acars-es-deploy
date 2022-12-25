REPO_PATH          := $(shell pwd)
DATA_PATH          := ${REPO_PATH}/data
ES_AUTH_INFO_PATH  := ${REPO_PATH}/es_auth_info.md

ELASTICSEARCH_PORT := 9200
KIBANA_PORT        := 5601

${DATA_PATH}/es:
	$(info Creating ES data directory at ${DATA_PATH}/es)
	@mkdir -p ${DATA_PATH}/es

${DATA_PATH}/kibana:
	$(info Creating Kibana data directory at ${DATA_PATH}/kibana)
	@mkdir -p ${DATA_PATH}/kibana
	
all: start
start: start_es start_kibana
stop: stop_es stop_kibana

run_kibana: ${DATA_PATH}/kibana
	@KIBANA_DATA_PATH="${DATA_PATH}/kibana" \
	 KIBANA_PORT="${KIBANA_PORT}" \
	 	docker-compose -f docker-compose.kibana.yaml up -d

stop_kibana:
	@KIBANA_PORT="${KIBANA_PORT}" docker-compose -f docker-compose.kibana.yaml stop

start_kibana: run_kibana
	@./scripts/wait_for.sh http://localhost:${KIBANA_PORT}
	
run_es: ${DATA_PATH}/es
	@./scripts/check_vm_map_count.sh
	@ELASTICSEARCH_DATA_PATH="${DATA_PATH}/es" \
	 ELASTICSEARCH_PORT="${ELASTICSEARCH_PORT}" \
	 	docker-compose -f docker-compose.es.yaml up -d

stop_es:
	@ELASTICSEARCH_PORT="${ELASTICSEARCH_PORT}" docker-compose -f docker-compose.es.yaml stop

${ES_AUTH_INFO_PATH}: run_es
	@./scripts/wait_for.sh http://localhost:${ELASTICSEARCH_PORT}
	@./scripts/reset_password.sh ${ES_AUTH_INFO_PATH}
	
start_es: run_es ${ES_AUTH_INFO_PATH}

reset_es_password:
	-@rm ${ES_AUTH_INFO_PATH}
	@./scripts/reset_password.sh ${ES_AUTH_INFO_PATH}
	
clean:
	$(info Removing ES and Kibana containers)
	-@./scripts/remove_containers.sh
	$(info Removing data directories at ${DATA_PATH})
	-@rm -I -r ${DATA_PATH}
	$(info Remove ES authentication info)
	-@rm ${ES_AUTH_INFO_PATH}
