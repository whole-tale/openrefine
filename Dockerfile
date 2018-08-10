FROM ubuntu:xenial-20180726

EXPOSE 3333

WORKDIR /app

RUN apt-get update -qqy && \
  apt-get install -y wget ant openjdk-8-jdk && \
  wget https://github.com/OpenRefine/OpenRefine/archive/2.8.tar.gz && \
  tar xf 2.8.tar.gz && \
  OpenRefine-2.8/refine build && \
  rm -rf 2.8.tar.gz && \
  apt-get remove -y ant openjdk-8-jdk && \
  apt-get install -y openjdk-8-jre-headless && \
  apt autoremove -qy && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN useradd -m -g 100 -G 100 -u 1000 -s /bin/bash wtuser

VOLUME /wholetale
WORKDIR /wholetale

RUN chown 1000:100 /wholetale
USER wtuser

EXPOSE 3333
CMD /app/OpenRefine-2.8/refine -i 0.0.0.0 -d /wholetale/home/openrefine
