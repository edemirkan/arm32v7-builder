FROM docker.io/agners/archlinuxarm-arm32v7:latest
# Prep base image
RUN pacman -Syu --noconfirm \  
    && pacman -S --noconfirm base-devel clang sdl2 lld\
    && rm -rfd /var/cache/pacman/pkg/*


WORKDIR /root/workspace/

CMD ["/bin/bash"]