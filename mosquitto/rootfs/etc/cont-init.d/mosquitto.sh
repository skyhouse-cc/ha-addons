#!/usr/bin/with-contenv bashio
# ==============================================================================
# Configures mosquitto
# ==============================================================================
readonly ACL="/etc/mosquitto/acl"
readonly PW="/etc/mosquitto/pw"
readonly SYSTEM_USER="/data/system_user.json"
declare cafile
declare certfile
declare discovery_password
declare keyfile
declare password
declare service_password
declare ssl
declare username

keyfile="/ssl/$(bashio::config 'keyfile')"
certfile="/ssl/$(bashio::config 'certfile')"
cafile="/ssl/$(bashio::config 'cafile')"
if bashio::fs.file_exists "${certfile}" \
  && bashio::fs.file_exists "${keyfile}";
then
  bashio::log.info "Certificates found: SSL is available"
  ssl="true"
  if ! bashio::fs.file_exists "${cafile}"; then
    cafile="${certfile}"
  fi
else
  bashio::log.info "SSL is not enabled"
  ssl="false"
fi

# Generate mosquitto configuration.
bashio::var.json \
  cafile "${cafile}" \
  certfile "${certfile}" \
  customize "^$(bashio::config 'customize.active')" \
  customize_folder "$(bashio::config 'customize.folder')" \
  keyfile "${keyfile}" \
  require_certificate "^$(bashio::config 'require_certificate')" \
  ssl "^${ssl}" \
  debug "^$(bashio::config 'debug')" \
  | tempio \
    -template /usr/share/tempio/mosquitto.gtpl \
    -out /etc/mosquitto/mosquitto.conf
