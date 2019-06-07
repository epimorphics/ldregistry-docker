#!/bin/sh

setProperty () {
  echo "SETTING PROPERTY: $1 = $2"
  sed -i "s|\($1[ \t]*=[ \t]*\)\(.*\)|\1 $2|g" /opt/ldregistry/config/app.conf
}

if [ -z $REGISTRY_BASE_PATH ]; then
  export REGISTRY_BASE_PATH=registry
fi
if [ $REGISTRY_BASE_URI ]; then
  # replace registry.baseUri with value of $REGISTRY_BASE_URI
  setProperty "registry.baseUri" $REGISTRY_BASE_URI
fi
if [ -z $USER_LOGIN ]; then
  export USER_LOGIN="dave@epimorphics.com"
fi
if [ -z $USER_PASSWORD ]; then
  export USER_PASSWORD="changeme"
fi
if [ $REGISTRY_REDIRECT_HTTPS_LOGIN ]; then
  # replace registry.baseUri with value of $REGISTRY_BASE_URI
  setProperty "registry.redirectToHttpsOnLogin" $REGISTRY_REDIRECT_HTTPS_LOGIN
fi

# set war to be at 8080/$REGISTRY_BASE_PATH
mv /opt/ldregistry/registry.war /usr/local/tomcat/webapps/$REGISTRY_BASE_PATH.war

# setup user with admin and password
envsubst < /etc/templates/user.ini.tmpl > /opt/ldregistry/config/user.ini

rm -f /var/opt/ldregistry/store/tdb.lock
rm -f /var/opt/ldregistry/index/write.lock

catalina.sh run
