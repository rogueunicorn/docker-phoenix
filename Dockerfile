FROM ubuntu:14.04.3

MAINTAINER Toby Hede <tobyhede@info-architects.net>

ENV BUILD_DATE 2015-12-01

ENV ELIXIR_VERSION 1.2.0
ENV MIX_ENV prod
ENV PORT 80

EXPOSE ${PORT}

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# update and install some software requirements
RUN apt-get update && apt-get upgrade -y && apt-get install -y build-essential git mysql-client postgresql-client wget

# download and install Erlang package
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
 && dpkg -i erlang-solutions_1.0_all.deb \
 && apt-get update

# install erlang from package
RUN apt-get install -y erlang erlang-ssl erlang-inets && rm erlang-solutions_1.0_all.deb

# install elixir from source
RUN git clone https://github.com/elixir-lang/elixir.git && cd elixir && git checkout v${ELIXIR_VERSION} && make
ENV PATH $PATH:/elixir/bin

# install mix
RUN /elixir/bin/mix local.hex --force && /elixir/bin/mix local.rebar --force && mix hex.info

ENV SRC ./app

COPY ${SRC} app

WORKDIR /app

RUN mix do deps.get, compile

COPY entrypoint.sh entrypoint.sh

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ./entrypoint.sh
