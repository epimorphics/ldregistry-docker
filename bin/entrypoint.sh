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
# set war to be at 8080/$REGISTRY_BASE_PATH
mv /opt/ldregistry/registry.war /usr/local/tomcat/webapps/$REGISTRY_BASE_PATH.war

# replace registry.baseUri with value of $REGISTRY_BASE_URI
sed -i "s|\(registry.baseUri[ \t]*=[ \t]*\)\(.*\)|\1 $REGISTRY_BASE_URI|g" /opt/ldregistry/config/app.conf

# setup user with admin and password
envsubst < /etc/templates/user.ini.tmpl > /opt/ldregistry/config/user.ini

rm /var/opt/ldregistry/store/tdb.lock
catalina.sh run
