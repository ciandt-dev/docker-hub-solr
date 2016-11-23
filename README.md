### CI&T Acquia Solr mimic Docker base image

This Docker image intends to be containerized mimic solution of Acquia Solr environment.

The source code is available under GPLv3 at Bitbucket in this [link](https://bitbucket.org/ciandt_it/docker-hub-solr).

Our intent is to have a Docker container that mimics Acquia Solr environment with the same version of softwares and OS.

Utilizing Docker technologies that already provides an easy way of spinning up new environments and its dependecies, this image can speed-up developers which different backgrounds and equipments to have a fast local environment allowing them to easily integrate in automated tests and deployment pipelines.

Keeping it short, this image contains the same working set of Ubuntu and Apache Solr Acquia utilizes.

### [*Quick Start*](#quickstart)

__Download the image__

```
docker pull ciandtsoftware/solr:acquia-2016-11-08
```

__Run a container__

```
docker run \
  --name myContainer \
  --detach \
  ciandtsoftware/solr:acquia-2016-11-08
```

__Check running containers__

```
docker ps --all
```

* * *

### [Software Versions](#software-versions)

These are the currently versions bundled in this image.

Already installed

* Ubuntu 12.04.5
* Solr 3.5.0
    * Drupal Search API 7.x-1.8
* Dumb-init 1.2.0

* * *

### [Running standalone](#running-standalone)

If you just need the container there is a snippet that can help running in standalone mode.

```
# define variables
DOCKER_CONTAINER_NAME="myContainer"
DOCKER_IMAGE="solr:acquia-2016-11-08"

# run your container
docker run \
  --name "${DOCKER_CONTAINER_NAME}" \
  --detach \
  "${DOCKER_IMAGE}"
```

After run, you can inquiry Docker service and get the IP address and port of your newly running container named __myContainer__ by using the following command:

```
docker inspect --format '{{ .NetworkSettings.IPAddress }} myContainer'
```

Let's suppose that the returned IP address was __172.17.0.2__.
Since Solr standard port is __8983__, just open a browser and try to access:

> http://172.17.0.2:8983

Apache Solr landing page should be displayed perfectly.

* * *

### [Running in Docker-Compose](#running-docker-compose)

Since a project is not going to use solely this container, it may need a Docker-Compose file.

Just to exercise, follow an example of this running with __Apache/PHP__ and also both behind a __Nginx__ proxy.

Create a new folder and fill with these 3 files and respective folders;

##### [__conf/acquia.local.env__](#acquia-env)

```
## Nginx proxy configuration
# https://hub.docker.com/r/jwilder/nginx-proxy/
VIRTUAL_HOST=mySite.local
```

##### [__conf/solr.local.env__](#acquia-env)

```
## Nginx proxy configuration
# https://hub.docker.com/r/jwilder/nginx-proxy/
VIRTUAL_HOST=mySolr.local
VIRTUAL_PORT=8983
```

##### [__docker-compose.yml__](#docker-compose)

```
solr:
  image: ciandtsoftware/solr:acquia-2016-11-08
  container_name: solr
  env_file: ../conf/solr.local.env

acquia:
  build: ./acquia
  container_name: acquia
  env_file: ../conf/acquia.local.env
  links:
    - solr

nginx:
  image: jwilder/nginx-proxy:latest
  container_name: nginx
  volumes:
    - /var/run/docker.sock:/tmp/docker.sock:ro
  ports:
    - "80:80"
    - "443:443"
```

Then just spin-up your Docker-Compose with the command:

```
docker-compose up -d
```

Inspect Nginx container IP address:

```
docker inspect \
        --format \
        "{{.NetworkSettings.Networks.bridge.IPAddress }}" \
        "nginx"
```

Use the IP address to update __hosts__ file. Let's suppose that was 172.17.0.2.

Then, add the entries to __/etc/hosts__.

> 172.17.0.2 acquia.local
> 172.17.0.2 solr.local

And now, try to access in the browser
> http://solr.local/solr/admin

Voilà!
Your project now have Solr, Apache/PHP and Nginx up and running.
\\o/

* * *

### [Contributing](#contributing)

If you want to contribute, suggest improvements and report issues, please go to our [Bitbucket repository](https://bitbucket.org/ipinatti_cit/docker-hub-solr).

* * *

Please feel free to drop a message in the comments section.

Happy coding, enjoy!!

"We develop people before we develop software" - Cesar Gon, CEO

* * *
