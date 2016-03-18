# Docker images

This repo contains Dockerfiles that build our runtime and build time stacks.
In order to add a new runtime / buildtime, just add the according Dockerfile and commit

## Naming

The name of the Dockerimage will be `meteogroup/<suffix of the Dockerfile>`. If you want to apply a certain tag, reflect this in the Dockerfile suffix:

  - if your Dockerfile is called `Dockerfile.java`, the image that gets build will be called `meteogroup/java:latest`
  - if your Dockerfile is called `Dockerfile.java:8`, the image that gets build will be called `meteogroup/java:8`

## php image

The php image is a copy from `million12/docker-nginx-php` flattened out in one file. In order to update the Dockerfile, execute:

    ./create-php-dockerfile <php-version>

where `<php-version>` is something like `56` for php version 5.6, `70` for php 7.0, etc.

    ./create-php-dockerfile 56

will create the file `Dockerfile.php56` and `Dockerfile.php56.orig`. Compare the two files: the `Dockerfile.php56` has some stuff removed that should not be part of a php runtime, but the removal part is done and needs review.


