FROM ubuntu:20.04 as build

LABEL maintainer="DavveDP"
LABEL version="0.1"
LABEL description="docker image for building hg-engine"

ADD hg-engine /hg-engine
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends libpng-dev build-essential cmake python3-pip automake wget git gnupg ca-certificates -y \
&& pip3 install --no-cache-dir ndspy \
&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
&& echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
&& apt-get update -y \
&& apt-get install --no-install-recommends mono-devel -y\
&& ln -s /proc/self/mounts /etc/mtab || true \
&& wget https://apt.devkitpro.org/install-devkitpro-pacman \
&& chmod +x ./install-devkitpro-pacman \
&& yes | ./install-devkitpro-pacman \
&& yes "" | dkp-pacman -S gba-dev\
&& rm install-devkitpro-pacman \
&& apt-get remove python3-pip wget -y \
&& cd /hg-engine \
&& make build_tools \
&& make build_nitrogfx

CMD export DEVKITPRO=/opt/devkitpro \ 
&& export DEVKITARM=$DEVKITPRO/devkitARM \ 
&& cd /hg-engine && make \
&& cp /hg-engine/test.nds /build || true
