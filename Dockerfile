FROM ubuntu:16.04
RUN apt-get update -y
RUN apt-get install -y git locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && dpkg-reconfigure --frontend=noninteractive locales && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
RUN git clone https://github.com/nonlinear-labs-dev/nonlinux
