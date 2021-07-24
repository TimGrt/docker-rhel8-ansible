FROM registry.access.redhat.com/ubi8/ubi-init
LABEL maintainer="Tim Gruetzmacher"
ENV container=docker

RUN dnf install -y python38 python38-pip sudo

# Upgrade pip to latest version.
RUN pip3 install --no-cache-dir --upgrade pip

# Install Ansible via pip.
RUN pip3 install --no-cache-dir ansible cryptography

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible \
    && printf "[local]\nlocalhost ansible_connection=local\n" > /etc/ansible/hosts

# Create `ansible` user with sudo permissions
ENV ANSIBLE_USER=ansible

RUN set -xe \
  && useradd -m ${ANSIBLE_USER} \
  && echo "${ANSIBLE_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]