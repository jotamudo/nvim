ARG DISTRO_VERSION=forky
ARG DEBIAN_FRONTEND=noninteractive

FROM debian:${DISTRO_VERSION} AS builder

ARG NEOVIM_VERSION=nightly
ARG BUILD_DEPS="ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl wget doxygen"

COPY ./build-neovim.sh /tmp/

RUN apt update && apt install -y ${BUILD_DEPS} && sh /tmp/build-neovim.sh

FROM debian:${DISTRO_VERSION}
COPY --from=builder /tmp/nvim/usr/ /usr/

RUN apt update && apt install -y rustup python3 python3-venv fish git gcc curl ninja-build pkg-config unzip tar wget ripgrep silversearcher-ag
RUN rustup install nightly
RUN rustup component add rust-analyzer

# Install fvm
RUN curl -fsSL https://fvm.app/install.sh | bash
RUN /usr/bin/fish -c 'fish_add_path /root/fvm/bin'

ENV PATH="$PATH:/root/fvm/default/bin"
ENV PATH="$PATH:/root/.pub-cache/bin"

ADD . /root/.config/nvim/

RUN nvim --headless -c 'Lazy sync' -c 'q'
RUN nvim --headless -c 'TSInstall all' -c 'q'
RUN nvim --headless -c 'MasonToolsInstallSync' -c 'q'

CMD ["/usr/bin/nvim"]
