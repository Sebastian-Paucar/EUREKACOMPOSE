FROM payara/server-full:5.2022.5-jdk17

# Variables
ENV PAYARA_DOMAIN=domain1 \
    DEPLOY_DIR=/opt/payara/deployments


# Copiar MySQL connector
COPY lib/mysql-connector-j-8.0.33.jar \
    /opt/payara/appserver/glassfish/domains/${PAYARA_DOMAIN}/lib/

# Crear carpeta de despliegue
RUN mkdir -p ${DEPLOY_DIR}

# ----------------------------
# SCRIPT POST-BOOT
# ----------------------------
# Se ejecuta al iniciar Payara y fuerza la URL del WSDL
RUN echo "\
asadmin set configs.config.server-config.web-service-container.property.webservice.endpoint.publish.enabled=true\n\
asadmin set configs.config.server-config.web-service-container.property.webservice.endpoint.publish.address=${EXTERNAL_ADDRESS}\n\
" > /opt/payara/config/post-boot.asadmin

# Exponer puertos
EXPOSE 8080 4848
