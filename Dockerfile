# hadolint global ignore=DL3007,DL3033
FROM registry.access.redhat.com/ubi8/ubi-init:latest
LABEL maintainer="Tim Gruetzmacher"

# Install requirements.
RUN yum -y install rpm dnf-plugins-core \
 && yum -y update \
 && yum -y install \
      initscripts \
      sudo \
      which \
      hostname \
 && yum clean all

# Create `ansible` user with sudo permissions
ENV ANSIBLE_USER=ansible

RUN set -xe \
  && useradd -m ${ANSIBLE_USER} \
  && echo "${ANSIBLE_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]