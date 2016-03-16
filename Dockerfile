FROM rogueunicorn/elixir

MAINTAINER RogueUnicorn <docker@rogueunicorn.xyz>

ENV MIX_ENV prod
ENV PORT    80
ENV SRC     ./hello-phoenix
ENV APP     hello_phoenix

EXPOSE ${PORT}

COPY ${SRC}/rel/${APP} app

WORKDIR /app

# RUN mix do local.hex, deps.get, compile, phoenix.digest, release

# CMD "mix phoenix.server"

COPY entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ./entrypoint.sh
