FROM debian:bookworm-slim

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends \
    python3 \
    curl \
    git \
    gpp \
    zsh \
    emacs-nox
