FROM      debian:jessie
MAINTAINER Camille Vaucelle <camille@organiknowledge.com>

RUN apt-get update && apt-get install -y \
	git \
	nginx \
	&& rm -rf /var/lib/apt/lists/*
