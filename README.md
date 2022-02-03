# packetcrypt-docker
Dockerfile for packetcrypt.

This uses a base rust image to build the packetcrypt binaries for debian.
The built sources are then passed to a blank minimal debian base image.

Rebuilt every week to fetch base image updates.
