FROM python:2.7-slim-buster

LABEL maintainer="sergii@shkolin.net.ua"

ARG OCTODNS_VERSION
ENV VERSION=${OCTODNS_VERSION:-v0.9.10}

ADD fix-list-order.patch /tmp

RUN apt update \
    && apt install -y --no-install-recommends git \
    && git clone -b ${VERSION} --single-branch --depth 1 https://github.com/github/octodns.git /tmp/octodns \
    && cd /tmp/octodns \
    && git apply /tmp/fix-list-order.patch \
    && pip install -r requirements.txt \
    && python setup.py install \
    && cd / \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/octodns-sync"]
