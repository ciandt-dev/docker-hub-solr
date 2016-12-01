# CI&T Solr Docker image(s)

This is the source code of [CI&T Solr Docker image(s)](https://hub.docker.com/r/ciandtsoftware/solr/) hosted at [Docker hub](https://hub.docker.com/).

It contents the source code for building the publicly accessible Docker image(s) and some scripts to easy maintain and update its code.

By utilizing Docker technologies, that already provides an easy way of spinning up new environments along with its dependecies. This image can speed up developers which different backgrounds and equipments to create quickly a new local environment allowing them to easily integrate in automated tests and deployment pipelines.

At this moment we have the following version(s)

## [Acquia](#acquia)

Our intent is to be a Docker container that mimics Solr running on Acquia environment with the same version of softwares, packages, modules and its underlying operating system.

Acquia publishes a table with its platform infrastructure information on the link: https://docs.acquia.com/cloud/arch/tech-platform

These images will have the following name pattern: __acquia-*YYYY-MM-DD*__

#### [*Bundled software versions*](#software-versions)

These are the currently software versions bundled in the image(s) by tag.

* acquia-latest __OR__ acquia-2016-11-30
  * Ubuntu 12.04.5
  * Solr 3.5.0
    * Drupal Search API 7.x-1.8
  * Dumb-init 1.2.0
__*Deprecated*__

* acquia-2016-11-08
  * Ubuntu 12.04.5
  * Solr 3.5.0
    * Drupal Search API 7.x-1.8
  * Dumb-init 1.2.0

* * *

# [Requirements](#requirements)

Since Docker at the moment was designed to run natively just on __Linux__, we do consider this as __premisse__.

And also, before proceeding please check the __required__ packages below:

 - docker engine => 1.12
 - make
 - grep
 - curl

* * *

# [Quick Start](#quickstart)

__*Clone the desired project code version*__

```
DESIRED_VERSION="acquia-latest"

git clone \
  --branch "${DESIRED_VERSION}" \
  git@github.com:ciandt-dev/docker-hub-solr.git
```

__*Build, run and test*__

```
make
```

* * *

## [How-to](#how-to)

It is possible to perform any of the actions described below:

### [*Build*](#how-to-build)

```
make build
```

### [*Run*](#how-to-run)

```
make run
```

### [*Test*](#how-to-test)

```
make test
```

### [*Debug*](#how-to-debug)

```
make debug
```

### [*Shell access*](#how-to-shell)

```
make shell
```

### [*Clean*](#how-to-clean)

```
make clean
```

### [*Clean All*](#how-to-clean-all)

```
make clean-all
```

### [*All - Build / Run / Test*](#how-to-all)

```
make all
```

<sub>*or simply*</sub>

```
make
```

* * *

## [Deep diving](#deep-dive)

### [*.env file*](#env)

As this little framework was designed to be re-utilized on other Docker images it contains a __.env__ file provided at repository root. This file has some self-described variables and they are used by all scripts to perform its own tasks, just inspect the .env file to check them out.

The only one that is important to mention is:

> __ENVIRONMENT__

Environment default value is always __local__. It is possible to change to any desired string value, this is just an ordinary alias to load one of the configuration files that can exist in __conf__ folder.

Example, if you change it to:

> ENVIRONMENT="__dev__"

When you __run__ (*not build*) the container will load variables from:

> conf/*$APP_NAME*.__dev__.env

This is an easy way to inject variables when developing a new script and testing multi-environment solution.

* * *

### [*Build process*](#build-process)

This process will execute instructions in Dockerfile that is inside __app__ folder.
Dockerfile will have several environment variables for the __build__ step, when you need to modify them please look for any line starting with __ENV__. More information about Dockerfile ENV (environment variables) is available at this [link](https://docs.docker.com/engine/reference/builder/#/env).

* * *

### [*Run process*](#run-process)

As described in <a name="env">.env file</a> section, run will load environment variables from an existing file inside __conf folder__.
This approach is better describe in official Docker docs in the [link](https://docs.docker.com/compose/env-file/).

* * *

### [*Debug and Shell access*](#debug-shell)

Wheter there is a need of __debuging__ or __inspecting__ inside the container there are two options to help:

```
make debug
```

and

```
make shell
```

The first one runs the container and attaches __*stderr*__ and __*stdout*__ to current terminal and prints relevant information.

Second one runs the container and connects to its shell (bash). So, you can inspect files, configurations and the whole container environment.

* * *

### [*Testing*](#testing)

After any modification we strongly recommend to run tests against the container to check if everything is running smoothly.

This can be done with the command:

```
make test
```

These are simple tests at the moment, therefore, very usefull.

* * *

### [*All steps*](#all-steps)

Now that you __already__ __read__ the previous steps, you are aware of each function. Knowing that, the easisest way of wrapping up everything together is to just run:

```
make
```

This command will __build__, __run__ and __test__ your recently created container.

### [*Cleaning up*](#cleaning-up)

Since Docker generates tons of layers that can fast outgrow your hard drive. After that you have finished any modification we encourage to clean up your environment.

There are two commands for this task:

```
make clean
```

It stops the running container, removes it and deletes its Docker image.
This particular one is very usefull when you are performing changes and you need to rebuild your container many times to check for modifications.
In addition, you can combine with __make shell__ for instance, like in this example:

```
make clean && make shell
```

And the second one is:

```
make clean-all
```

Actually, this one calls __make clean__ first, and then removes Docker __dangling images and volumes__.
More information about dangling images/volumes can be found at this [link](https://docs.docker.com/engine/reference/commandline/images/).

* * *

## [User Feedback](#user-feedback)

### [*Issues*](#issues)

If you have problems, bugs, issues with or questions about this, please reach us in [Github issues page](https://github.com/ciandt-dev/docker-hub-solr/issues).

__Needless to say__, please do a little research before posting.

### [*Contributing*](#contributing)

We gladly invite you to contribute fixes, new features, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a GitHub issue, especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.

### [*Documentation*](#documentation)

There are __two parts__ of the documentation.

First, in the master branch, is this README.MD. It explains how this little scripts framework work and it is published on [Github page](https://github.com/ciandt-dev/docker-hub-solr).

Second, in each image version there is an additional README.MD file that explains how to use that specific Docker image version itself. __*Latest version*__ is always the one seen on [Docker Hub page](https://hub.docker.com/r/ciandtsoftware/solr).

We strongly encourage reading both!

* * *

Happy coding, enjoy!!

"We develop people before we develop software" - Cesar Gon, CEO
