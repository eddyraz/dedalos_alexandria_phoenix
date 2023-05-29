FROM docker.uclv.cu/elixir:1.14.2-alpine
WORKDIR /app
COPY . .
RUN mix local.hex --force && \
    mix local.rebar --force && \
    HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get

RUN mix deps.compile

ENV POSTGRES_USER=edr \
    POSTGRES_PASSWORD=H@bana2019* \
    POSTGRES_HOST=55432 \
    POSTGRES_DB=dedalos_phoenix_dev

EXPOSE 4009
CMD ["iex", "-S", "mix", "phx.server"]