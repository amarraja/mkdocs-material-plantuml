FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y git curl python3 python3-pip default-jre graphviz && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L http://sourceforge.net/projects/plantuml/files/plantuml.1.2019.3.jar/download > /opt/plantuml.jar

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /tmp

RUN git clone --branch 4.0.2 https://github.com/squidfunk/mkdocs-material.git && \
    cd mkdocs-material && \
    python3 setup.py install && \
    cd - && \
    rm -fr mkdocs-material && \
    pip3 install plantuml-markdown

COPY bin/plantuml /usr/bin/plantuml
RUN chmod 755 /usr/bin/plantuml

WORKDIR /docs
EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
