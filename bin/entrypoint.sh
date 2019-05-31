#!/bin/sh
if [ $REGISTRY_BASE_PATH ]; then
  mv /usr/local/tomcat/webapps/registry.war /usr/local/tomcat/webapps/$REGISTRY_BASE_PATH.war
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
envsubst '${REGISTRY_BASE_URI}' < /etc/templates/app.conf.tmpl > /opt/ldregistry/config/app.conf
envsubst < /etc/templates/user.ini.tmpl > /opt/ldregistry/config/user.ini
rm /var/opt/ldregistry/store/tdb.lock
catalina.sh run
