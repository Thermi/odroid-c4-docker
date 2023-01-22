FROM ubuntu:14.04
MAINTAINER BPI  "BPI-SINOVOIP"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y \
	apt-utils \
	openssh-server  build-essential \
    gcc-arm-linux-gnueabihf \
	g++-arm-linux-gnueabihf \
    gcc-arm-linux-gnueabi \
    g++-arm-linux-gnueabi \
    gcc-arm-none-eabi \
	unzip \
    sudo \
    git \
    mercurial \
	vim \
    bc \
    u-boot-tools \
	device-tree-compiler \
    pkg-config \
    libusb-1.0-0-dev \
	software-properties-common \
	libtinfo5 \
    libncurses5-dev \
	libncurses5 \
	busybox \
	locales \
	m4 \
    zip \
	net-tools \
	rsync
ADD gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu.tar.xz /opt/toolchains/
ADD gcc-linaro-aarch64-none-elf-4.9-2014.09_linux.tar.xz /opt/toolchains/
ADD gcc-linaro-arm-none-eabi-4.8-2014.04_linux.tar.xz /opt/toolchains/
RUN /bin/sh -c chown -R root:root /opt
ADD dtc /usr/bin/dtc
RUN /bin/sh -c locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
RUN /bin/sh -c mkdir /var/run/sshd
RUN /bin/sh -c echo 'root:root' | chpasswd
RUN /bin/sh -c sed -i 's/AcceptEnv LANG LC_*/#AcceptEnv LANG LC_*/g' /etc/ssh/sshd_config
RUN /bin/sh -c sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN /bin/sh -c sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN /bin/sh -c if ! test -e /usr/bin/python; then ln -s /usr/bin/python2 /usr/bin/python; fi
ADD build-odroid-c4.sh in /
EXPOSE 22
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/toolchains/gcc-linaro-aarch64-none-elf-4.9-2014.09_linux/bin:/opt/toolchains/gcc-linaro-arm-none-eabi-4.8-2014.04_linux/bin:/opt/toolchains/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu/bin
CMD ["bash"]
