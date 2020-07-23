FROM python:3.7

LABEL maintainer="sergii@shkolin.net.ua"

ENV VERSION=v0.9.10

RUN wget --quiet https://raw.githubusercontent.com/github/octodns/${VERSION}/requirements.txt -O requirements.txt &&\
    pip install -e git+https://github.com/github/octodns.git@${VERSION}#egg=octodns &&\
    pip install -r requirements.txt

ENTRYPOINT ["/usr/local/bin/octodns-sync"]
