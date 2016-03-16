FROM rogueunicorn/elixir

MAINTAINER RogueUnicorn <docker@rogueunicorn.xyz>

ENV MIX_ENV prod
ENV PORT    80
ENV SRC     ./hello-phoenix
ENV APP     hello_phoenix

EXPOSE ${PORT}

COPY ${SRC} app

WORKDIR /app

# RUN mix local.hex --force
RUN mix do deps.get, compile, phoenix.digest, release

COPY entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ./entrypoint.sh
