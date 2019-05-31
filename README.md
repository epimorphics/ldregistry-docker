# LD Registry in docker

## Environment Variables

| Variable | Description | Default |
| --- | --- | --- |
| REGISTRY_BASE_PATH | base path for registry instance | registry |
| REGISTRY_BASE_URI | base uri for registry instance | http://localhost/registry |
| USER_LOGIN | admin user login | dave@epimorphics.com |
| USER_PASSWORD | admin user password | changeme |

## running

with a tdb image in a directory `store` run `docker-compose up` or
`docker run -it -p 80:8080 -v $(pwd)/store:/var/opt/ldregistry/store epimorphics/registry:2.0.1-SNAPSHOT`
