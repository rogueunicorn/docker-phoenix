#!/bin/sh
mix ecto.create
mix ecto.migrate
${SRC}/rel/${APP}/bin/${APP} start
