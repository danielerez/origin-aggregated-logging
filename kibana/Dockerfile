FROM rhscl/nodejs-10-rhel7

MAINTAINER OpenShift Development <dev@lists.openshift.redhat.com>

EXPOSE 5601

ENV ELASTICSEARCH_URL=https://elasticsearch.openshift-logging.svc.cluster.local:9200 \
    HOME=/opt/app-root/src  \
    KIBANA_CONF_DIR=${HOME}/config \
    KIBANA_VERSION=6.8.1 \
    NODE_ENV=production \
    RELEASE_STREAM=prod \
    container=oci \
    NODE_ENV=production \
    NODE_PATH=/opt/rh/rh-nodejs10/root/usr/bin


ARG LOCAL_REPO

USER 0

COPY vendored_tar_src/ ${HOME}/

RUN chmod -R og+w ${HOME}/
ADD probe/ /usr/share/kibana/probe/
ADD kibana.yml ${KIBANA_CONF_DIR}/
ADD run.sh utils ${HOME}/
RUN sed -i -e 's/"node":.*/"node": "'$(${NODE_PATH}/node --version | sed 's/v//')'"/' package.json && \
    mkdir -p node && \
    ln -s ${NODE_PATH} node/bin && \
    mkdir -p ${HOME}/x-pack && \
    ln -s ${HOME}/x-pack ${HOME}/node_modules/x-pack
RUN bin/kibana --optimize

WORKDIR ${HOME}
CMD ["./run.sh"]

LABEL \
        io.k8s.description="Kibana container for querying Elasticsearch for aggregated logs" \
        com.redhat.component="logging-kibana6-container" \
        vendor="Red Hat" \
        name="openshift4/ose-logging-kibana6" \
        License="GPLv2+" \
        io.k8s.display-name="Kibana" \
        version="v4.2.0" \
        architecture="x86_64" \
        release="0.0.0.1" \
        io.openshift.expose-services="5601:http" \
        io.openshift.tags="logging,elk,kibana"
