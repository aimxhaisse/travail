FROM debian:bookworm-slim

ARG UID
ARG GID
ARG USERNAME

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      python3 \
      curl \
      git \
      gpp \
      zsh \
      sudo \
      emacs-nox

RUN groupadd -f -g ${GID} ${USERNAME}
RUN useradd -u ${UID} -g ${GID} ${USERNAME} --create-home
RUN usermod -aG sudo ${USERNAME}

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN curl -fsSL https://opencode.ai/install | bash
RUN echo "PATH=${PATH}:/home/${USERNAME}/.opencode/bin" >> ~/.zshrc
RUN /home/${USERNAME}/.opencode/bin/opencode stats

RUN curl https://mise.run | sh
RUN echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc

RUN echo 'PROMPT="[🔨] $PROMPT"' >> ~/.zshrc

COPY --chmod=755 entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
