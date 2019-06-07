FROM openjdk:8-alpine as builder
RUN apk add --update --no-cache maven bash
COPY registry-core/pom.xml .
RUN mvn dependency:resolve
RUN mkdir /app
WORKDIR /app
COPY registry-core/ .
RUN mvn clean package -DskipTests

FROM tomcat:7-jre8-alpine
RUN apk add --no-cache --update gettext
COPY --from=builder /app/target/registry-core-2.0.1-SNAPSHOT.war /opt/ldregistry/registry.war
RUN mkdir -p /var/opt/ldregistry/logstore
COPY registry-config-base/ldregistry /opt/ldregistry
COPY bin/entrypoint.sh entrypoint.sh
COPY templates/ /etc/templates/
# Newer versions of tomcat complain about cookies containing whitespace
#COPY context.xml /usr/local/tomcat/conf/context.xml
CMD ["./entrypoint.sh"]
