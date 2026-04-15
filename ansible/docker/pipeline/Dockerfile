FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 python3-pip ssh \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --break-system-packages ansible

WORKDIR /workspace

CMD ["bash"]