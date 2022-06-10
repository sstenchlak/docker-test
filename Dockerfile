FROM debian:stretch-slim
RUN apt-get -y update
RUN apt-get install -y curl gnupg2
RUN echo "deb http://download.opensuse.org/repositories/home:/mkoutny:/fykos/Debian_9.0/ ./" > /etc/apt/sources.list.d/fks.list
RUN curl -L https://build.opensuse.org/projects/home:mkoutny:fykos/public_key | apt-key add -
RUN apt-get -y update
RUN apt-get install -y fks-buildtools

WORKDIR /usr/src/local
