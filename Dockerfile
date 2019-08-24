FROM openjdk:11.0.4-jdk-stretch

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Versions
ARG SCALA_VERSION
ARG SBT_VERSION

# Envs
ENV SCALA_VERSION ${SCALA_VERSION:-2.13.0}
ENV SBT_VERSION ${SBT_VERSION:-1.2.8}

# Update and install packages 
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends apt-transport-https gnupg ca-certificates vim

# Install sbt
RUN curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
    dpkg -i sbt-$SBT_VERSION.deb && \
    rm sbt-$SBT_VERSION.deb && \
    apt-get update && \
    apt-get install sbt

# Install Scala
RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc

COPY . /root/work
WORKDIR /root/work

# Initialize
RUN sbt about
