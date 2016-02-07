FROM alpine

MAINTAINER Toby Hede <toby@tobyhede.com>

ENV BUILD_DATE 2015-12-01

ENV ELIXIR_VERSION 1.2.0
ENV MIX_ENV prod
ENV PORT 80

EXPOSE ${PORT}

RUN apk update && apk upgrade \
  && apk add ca-certificates \
  && rm -rf /var/cache/apk/*

RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
  && echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
  && apk update && apk upgrade \
  && apk add erlang-crypto@edge \
  && apk add elixir@edge \
  && mix local.hex --force \
  && rm -rf /var/cache/apk/*


#
# # download and install Erlang package
# RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
#  && dpkg -i erlang-solutions_1.0_all.deb \
#  && apt-get update
#
# # install erlang from package
# # RUN apt-get install -y erlang erlang-ssl erlang-inets && rm erlang-solutions_1.0_all.deb
#
# # install elixir from source
# RUN git clone https://github.com/elixir-lang/elixir.git && cd elixir && git checkout v${ELIXIR_VERSION} && make
# ENV PATH $PATH:/elixir/bin
#
# # install mix
# RUN /elixir/bin/mix local.hex --force && /elixir/bin/mix local.rebar --force && mix hex.info
#
# ENV SRC ./app
#
# COPY ${SRC} app
#
# WORKDIR /app
#
# RUN mix do deps.get, compile
#
# COPY entrypoint.sh entrypoint.sh
#
# RUN chmod +x ./entrypoint.sh
#
# ENTRYPOINT ./entrypoint.sh
