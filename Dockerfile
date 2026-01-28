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
      emacs-nox


RUN groupadd -f -g ${GID} ${USERNAME}
RUN useradd -u ${UID} -g ${GID} ${USERNAME} --create-home
RUN usermod -aG sudo ${USERNAME}

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# mise
RUN curl https://mise.run | sh
RUN echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
