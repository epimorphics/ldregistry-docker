#!/bin/sh
if [ -z $REGISTRY_BASE_PATH ]; then
  export REGISTRY_BASE_PATH=registry
fi
if [ -z $REGISTRY_BASE_URI ]; then
  REGISTRY_BASE_URI="http://localhost/registry"
fi
if [ -z $USER_LOGIN ]; then
  export USER_LOGIN="dave@epimorphics.com"
fi
if [ -z $USER_PASSWORD ]; then
  export USER_PASSWORD="changeme"
fi
echo $USER_LOGIN $USER_PASSWORD
mv /opt/ldregistry/registry.war /usr/local/tomcat/webapps/$REGISTRY_BASE_PATH.war
envsubst '${REGISTRY_BASE_URI}' < /etc/templates/app.conf.tmpl > /opt/ldregistry/config/app.conf
envsubst '${REGISTRY_BASE_PATH}' < /etc/templates/_navbar.vm.tmpl > /opt/ldregistry/templates/nav/_navbar.vm
envsubst < /etc/templates/user.ini.tmpl > /opt/ldregistry/config/user.ini
#envsubst < /etc/templates/server.xml.tmpl > /usr/local/tomcat/conf/server.xml
rm /var/opt/ldregistry/store/tdb.lock
catalina.sh run
