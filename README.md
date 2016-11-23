## CI&T Acquia Solr mimic Docker base image

This is the source code of [CI&T Acquia Solr Docker image](https://hub.docker.com/r/ciandtsoftware/solr/) hosted at [Docker hub](https://hub.docker.com/).

It contents the source code for building the publicly accessible Docker image and some scripts to easy maintain and update its code.

Our intent is to have a Docker container that mimics Acquia Solr environment with the same version of softwares and OS.

Utilizing Docker technologies that already provides an easy way of spinning up new environments and its dependecies, this image can speed-up developers which different backgrounds and equipments to have a fast local environment allowing them to easily integrate in automated tests and deployment pipelines.

Keeping it short, this image contains a working set of Ubuntu and Apache Solr.

* * *

## [*Quick Start*](#quickstart)

__Clone the project code__

```
git clone https://bitbucket.org/ciandt_it/docker-hub-solr.git
```

__Checkout the latest tag__

```
git checkout acquia-2016-11-08
```

__Build__

```
make
```
* * *

## [*Requirements*](#requirements)

Before proceeding please check the required packages below:

 - docker engine => 1.12
 - make
 - grep
 - curl

* * *

## [Software Versions](#software-versions)

These are the currently versions bundled in this image.

Already installed

* Ubuntu 12.04.5
+ Solr 3.5.0
    * Drupal Search API 7.x-1.8
* Dumb-init 1.2.0

* * *

## [Build process](#build-process)

There are some required environment variables that are already pre-defined in Dockerfile to specify software versions for the build step, if you need to modify them, please look for any line starting with __ENV__.

More information about ENV is available at this [link](https://docs.docker.com/engine/reference/builder/#/env).

* * *

## [.env](#env)

Thinking in a multi-stage environment, a file name __.env__ is provided at repository root and it is used to define which set of ENV variables are going to load-up during Docker run.

Default value is:

> __ENVIRONMENT="local"__

It is possible to change to any desired string value. This is just an ordinary alias to load one of configuration files that can exist in __conf__ folder.

Example, if you change it to:

> ENVIRONMENT="__dev__"

When you run the container it will load variables from:

> conf/solr.__dev__.env

It is an easy way to inject new variables when developing a new script.

* * *

## [Run process](#run-process)

As described in .env section, run will load environment variables from a file.
This approach is better describe in official Docker docs in the [link](https://docs.docker.com/compose/env-file/).

* * *

## [Debug and Shell access](#debug-shell)

Case there is a need of debug or inspect inside the container there are two options to help:

> make debug

and

> make shell

The first one runs the container and attaches __stderr__ and __stdout__ to current terminal and prints relevant information.

Second one runs the container and connects to its shell (bash) with root access. So, you can inspect files, configurations and the whole container environment.

* * *

## [Testing](#testing)

After any modification we strongly recommend to run tests against the container to check if everything is running smoothly.
This can be done with the command:

> make tests

These are simple tests at the moment, therefore, very usefull.

* * *

## [All steps](#all-steps)

Now that you __already__ __read__ the previous steps, you are aware of each function. Having said that, the easisest way of wrapping up everything together is to just run:

> make

or

> make all

This command will __build__, __run__ and __test__ your recently created container.

## [Cleaning up](#cleaning-up)

Since Docker generates tons of layers that can fast outgrow your hard drive, after that you have finished any modification, we encourage to clean up your environment.

There are two commands for this task:

> make clean

That stops the running container, removes it and deletes its Docker image.
This particular one is very usefull when you are performing cjanges and you need to rebuild your container to check for modifications.
In addition, you can combine with __make shell__ for instance, like in this example:

> make clean && make shell

And the second one is:

> make clean-all

Actually, this one calls __make clean__ and then removes Docker dangling images and volumes.
More information about dangling can be found at this [link](https://docs.docker.com/engine/reference/commandline/images/).

* * *

## [How-to](#how-to)

There is a Makefile in the root of the repository with all actions that can be performed.

#### [Build](#how-to-build)

```
make build
```

#### [Run](#how-to-run)

```
make run
```

#### [Test](#how-to-test)

```
make test
```

#### [Debug](#how-to-debug)

```
make debug
```

#### [Shell access](#how-to-shell)

```
make shell
```

#### [Clean](#how-to-clean)

```
make clean
```

#### [Clean All](#how-to-clean-all)

```
make clean-all
```

#### [All - Build / Run / Test](#how-to-all)

```
make all
```

Or simply

```
make
```

* * *

## [More](#more)

Furthermore, there is an additional documentation at our Docker Hub page at https://hub.docker.com/r/ciandtsoftware/acquia/ .

We strongly encourage reading it too!

* * *

Happy coding, enjoy!!

"We develop people before we develop software" - Cesar Gon, CEO
