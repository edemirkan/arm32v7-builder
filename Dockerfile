FROM docker.io/agners/archlinuxarm-arm32v7

# Prep base image
RUN pacman -Syu --noconfirm \
    base-devel clang sdl2 lld

WORKDIR /root/workspace/

CMD ["/bin/bash"]