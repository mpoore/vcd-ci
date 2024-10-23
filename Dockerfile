FROM quay.io/centos/centos:stream9 AS base
ARG VERSION
ARG BINARY
ARG ARTIFACTORY_URL
LABEL maintainer="mpoore.io"
LABEL version="$VERSION"

# Install packages
RUN dnf install -y alsa-lib chkconfig coreutils initscripts iproute --allowerasing --setopt=install_weak_deps=False && \
    dnf install -y libICE libSM libX11 libXau libXdmcp libXext libXi --allowerasing --setopt=install_weak_deps=False && \
    dnf install -y libXt libXtst module-init-tools openssl net-tools --allowerasing --setopt=install_weak_deps=False && \
    dnf install -y pciutils procps python3-distro wget which --allowerasing --setopt=install_weak_deps=False

# Add VMware GPG keys
FROM base
RUN rpm --import https://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub

# Add VMware Cloud Director Binary
RUN wget -q -P /home/ ${ARTIFACTORY_URL}/${BINARY} --no-check-certificate && \
    chmod 777 /home/${BINARY}