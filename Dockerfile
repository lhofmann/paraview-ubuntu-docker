ARG ubuntu_version="18.04"
FROM ubuntu:${ubuntu_version}

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    devscripts build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list && apt-get update

RUN useradd -c paraview -d /home/paraview -M paraview \
    && mkdir /home/paraview                           \
    && chown paraview:paraview /home/paraview

USER paraview
WORKDIR /home/paraview/
RUN apt-get source paraview \
    && rm *.tar.xz && rm *.dsc \
    && mv $(ls -1d */ | head -n 1) paraview

WORKDIR /home/paraview/paraview

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get build-dep -y paraview \
    && rm -rf /var/lib/apt/lists/*

USER paraview
RUN debuild -b -us -uc

ENV ParaView_DIR=/home/paraview/paraview/obj-x86_64-linux-gnu
