FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 python3-pip sudo ssh \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --break-system-packages ansible

RUN groupadd -r spear \
    && useradd -m -r -g spear spear \
    && echo "spear ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/spear \
    && chmod 0440 /etc/sudoers.d/spear

WORKDIR /workspace

CMD ["bash"]