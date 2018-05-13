FROM rabbitmq:management-alpine

MAINTAINER Andy Savage <andy@savage.hk>

LABEL org.label-schema.name="rabbitmq-plugins" \
      org.label-schema.description="Docker Image of RabbitMQ adding extra plugins" \
      org.label-schema.vcs-url="https://github.com/hongkongkiwi/rabbitmq-plugins" \
      org.label-schema.license="MIT"

ARG RABBITMQ_PLUGINS_DIR="/usr/lib/rabbitmq/plugins"

ARG RABBITMQ_VER="3.7.x"
ARG RABBITMQ_DEDUP_PLUGIN_VER="0.2.1"
ARG RABBITMQ_DEDUP_PLUGIN_URL="https://github.com/noxdafox/rabbitmq-message-deduplication/releases/download/${RABBITMQ_DEDUP_PLUGIN_VER}/rabbitmq_message_deduplication-${RABBITMQ_DEDUP_PLUGIN_VER}.ez"
ARG RABBITMQ_DELAYED_PLUGIN_URL="https://dl.bintray.com/rabbitmq/community-plugins/${RABBITMQ_VER}/rabbitmq_delayed_message_exchange"
ARG RABBITMQ_NODE_STAMP_PLUGIN_URL="https://dl.bintray.com/rabbitmq/community-plugins/${RABBITMQ_VER}/rabbitmq_routing_node_stamp"
ARG RABBITMQ_MESSAGE_TIMESTAMP_PLUGIN_URL="https://dl.bintray.com/rabbitmq/community-plugins/${RABBITMQ_VER}/rabbitmq_message_timestamp"
ARG RABBITMQ_AUTH_BACKEND_IP="https://dl.bintray.com/rabbitmq/community-plugins/${RABBITMQ_VER}/rabbitmq_auth_backend_ip_range"
ARG RABBITMQ_AUTH_BACKEND_HTTP="https://dl.bintray.com/rabbitmq/community-plugins/${RABBITMQ_VER}/rabbitmq_auth_backend_http"

# Download this plugin
ADD "${RABBITMQ_DEDUP_PLUGIN_URL}" "${RABBITMQ_PLUGINS_DIR}"
ADD "${RABBITMQ_DELAYED_PLUGIN_URL}" "${RABBITMQ_PLUGINS_DIR}"
ADD "${RABBITMQ_NODE_STAMP_PLUGIN_URL}" "${RABBITMQ_PLUGINS_DIR}"
ADD "${RABBITMQ_MESSAGE_TIMESTAMP_PLUGIN_URL}" "${RABBITMQ_PLUGINS_DIR}"
ADD "${RABBITMQ_AUTH_BACKEND_IP}" "${RABBITMQ_PLUGINS_DIR}"
ADD "${RABBITMQ_AUTH_BACKEND_HTTP}" "${RABBITMQ_PLUGINS_DIR}"

RUN rabbitmq-plugins enable rabbitmq_message_deduplication
RUN rabbitmq-plugins enable rabbitmq_delayed_message_exchange
RUN rabbitmq-plugins enable rabbitmq_routing_node_stamp
RUN rabbitmq-plugins enable rabbitmq_message_timestamp
RUN rabbitmq-plugins enable rabbitmq_auth_backend_ip_range
RUN rabbitmq-plugins enable rabbitmq_auth_backend_http

EXPOSE 15671 15672 4369 5671 5672 25672
