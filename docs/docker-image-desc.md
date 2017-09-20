# Short Description
Health Information Exchange Open Source (HIEOS) is used as Xds.b repository in  Consent2Share.

# Full Description

# Supported Tags and Respective `Dockerfile` Links

[`1.2.1`](https://github.com/bhits/dockerized-hieos/releases/tag/1.2.1)

[`Current Dockerfile`](https://github.com/bhits/dockerized-hieos/Dockerfile)


# What is HIEOS?

Health Information Exchange Open Source (HIEOS) is an open source implementation of, primarily server-side, Integrating the Healthcare Enterprise (IHE) Integration Profiles including Cross Enterprise Document Sharing (XDS.b) and Cross Community Access (XCA) integration profiles.

For more information and related downloads for HIEOS, please visit [HIEOS](https://sourceforge.net/projects/hieos/).
For more information and related downloads for Consent2Share, please visit [Consent2Share](https://bhits.github.io/consent2share/).

# How to use this image

## Start a HIEOS instance

`docker run  --name hieos -d bhits/hieos:1.2.1`

*NOTE: In order for this API to fully function as a microservice in the Consent2Share application, it is required to setup the dependency microservices and support level infrastructure. Please refer to the [Consent2Share Deployment Guide](https://github.com/bhits/consent2share/releases/download/2.0.0/c2s-deployment-guide.pdf) for instructions to setup the Consent2Share infrastructure.*


## Configure

This docker images runs with [domain.xml](https://github.com/bhits/dockerized-hieos/domain.xml).

`docker run  --name hieos --link="adt-db.c2s.com"  --link="log-db.c2s.com" --link="repo-db.c2s.com" --link="registry-db.c2s.com" -d bhits/hieos:1.2.1`

### Using a custom configuration file

To use custom `domain.xml`, mount the file to the docker container under `/glassfish/domains/domain1/config`.

`docker run -v "/path/on/dockerhost/domain.xml:/glassfish/domains/domain1/config/domain.xml" -d bhits/hieos:1.2.1`

# Supported Docker versions

This image is officially supported on Docker version 1.12.1.

Support for older versions (down to 1.6) is provided on a best-effort basis.

Please see the [Docker installation documentation](https://docs.docker.com/engine/installation/) for details on how to upgrade your Docker daemon.

# License

View [license](https://github.com/bhits/dockerized-openempi/LICENSE) information for the software contained in this image.

# User Feedback

## Documentation 

Documentation for this image is stored in the [bhits/dockerized-openempi](https://github.com/bhits/dockerized-openempi) GitHub repository. Be sure to familiarize yourself with the repository's README.md file before attempting a pull request.

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/bhits/dockerized-openempi/issues).