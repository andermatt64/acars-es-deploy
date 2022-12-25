# acars-es-deploy
Docker Compose deployment Makefile to deploy ElasticSearch and Kibana.
The ideal scenario is for ElasticSearch and Kibana on two different machines.

### Deployment Instructions
The setup assumes computer **A** is acting as the ElasticSearch server and **B** acting as the Kibana server.

On computer **A**:
 1. Create a new file `/etc/sysctl.d/99-es-max-map.conf` with the following contents:
<pre>
vm.max_map_count=262144
</pre> 
 2. Run the following command to enable external access to ElasticSearch ports:
<pre>
sudo firewall-cmd --zone=public --permanent --add-port=9200/tcp
</pre>
 3. Run `make start_es`
 4. Take note of the ElasticSearch authentication information in `es_auth_info.md`

On computer **B**:
 1. Optionally, enable external Kibana port access via the following command, add `--permanent` to ensure the rule sticks around after a reboot.:
<pre>
sudo firewall-cmd --zone=public --add-port=5601/tcp
</pre>
 2. Create a `.env` file with the following contents, replace `[kibana_system password]` with the password for `kibana_system` in `es_auth_info.md` from computer **A**:
<pre>
KIBANA_SYSTEM_PASSWORD="[kibana_system password]"
</pre>
 3. Run `make start_kibana`
 4. Open [http://localhost:5601](http://localhost:5601) on computer **B** and use the `elastic` user authentication from `es_auth_info.md` from computer **A** to log in

