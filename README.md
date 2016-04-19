# Docker images

This repo contains Dockerfiles that build our runtime and build time stacks.
In order to add a new runtime / buildtime, just add the according Dockerfile and test file and commit

## Naming

The name of the Dockerimage will be `meteogroup/<suffix of the Dockerfile>`. If you want to apply a certain tag, reflect this in the Dockerfile suffix:

  - if your Dockerfile is called `Dockerfile.java`, the image that gets build will be called `meteogroup/java:latest`
  - if your Dockerfile is called `Dockerfile.java:8`, the image that gets build will be called `meteogroup/java:8`

## php image

### create php Dockerfile

The php image is a copy from `million12/docker-nginx-php` flattened out in one file + omitting some unnecessary software. In order to update the Dockerfile, execute:

    ./create-php-dockerfile <php-version>

where `<php-version>` is something like `56` for php version 5.6, `70` for php 7.0, etc.

    ./create-php-dockerfile 56

will create the file `Dockerfile.php:56`, `Dockerfile.php:56.orig` and `Dockerfile.php-dev:56` . Compare `Dockerfile.php:56` and `Dockerfile.php:56.orig` as the script removes stuff that should not be part of a php runtime.

### comparing local Dockerfile against upstream version

In order to check whether the local, flattened out, docker file is still up to date with the million12/docker-nginx-php file, execute

    ./compare-against-upstream-php <php-version>

This will complain if any of the Dockerfile or the container files of the upstream project failed

## building one or more docker images

The repo includes a script to build docker image. It basically sets the docker tag automatically

    ./build-image [Dockerfile.<suffix1>] [Dockerfile.<suffix2>] ...

## testing one or more docker images

All docker images should have a respective test file.  There is a script that executes the tests: it basically just executes the `test.<suffix>` in the respective docker container.

    ./test-image [test.<suffix1>] [test.<suffix2>]

## build, test & push

    PUSH_IMAGE=1 ./build-image [Dockerfile.<suffix1>] [Dockerfile.<suffix2>] ...

will build, test and push the docker image. Note that each docker

