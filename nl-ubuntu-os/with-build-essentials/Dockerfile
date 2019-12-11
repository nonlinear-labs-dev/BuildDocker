FROM nl-ubuntu-os

ARG docker_group_id
ARG user
ARG user_id

RUN echo $docker_group_id
RUN echo $user
RUN echo $user_id

RUN groupadd -g $docker_group_id $user
RUN useradd -l -u $user_id -g $user $user
RUN apt-get update
RUN apt-get install -y git cmake build-essential wget cpio python unzip bc doxygen curl libcurl4-openssl-dev openjdk-8-jdk bash
