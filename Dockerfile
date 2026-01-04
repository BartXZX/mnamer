FROM ghcr.io/astral-sh/uv:alpine AS builder
RUN apk add git inotify-tools

ARG UID=1000
ARG GID=1000
RUN addgroup mnamer -g $GID
RUN adduser mnamer -u $UID -G mnamer --disabled-password
USER mnamer

ENV UV_COMPILE_BYTECODE=1
ENV UV_NO_DEV=1
ENV UV_TOOL_BIN_DIR=/usr/local/bin

ENV MNAMER_SOURCE_DIR="/media"
ENV MNAMER_CONFIG_PATH="/config/.mnamer-v2.json"

COPY --chown=$UID:$GID . /app
WORKDIR /app

RUN uv sync --locked

ENV PATH="/app/.venv/bin:$PATH"
ENV PYTHONPATH=/app/.venv/lib/python3.13/site-packages

WORKDIR /app
ENTRYPOINT ["/bin/sh", "/app/run.sh"]