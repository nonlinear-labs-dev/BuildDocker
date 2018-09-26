#!/bin/sh

docker build -t nl-ubuntu-os ./nl-ubuntu-os
docker build -t nl-ubuntu-os/with-build-essentials ./nl-ubuntu-os/with-build-essentials
docker build -t nl-ubuntu-os/with-build-essentials/with-nonlinux-repo ./nl-ubuntu-os/with-build-essentials/with-nonlinux-repo
docker build -t nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux ./nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux
docker build -t nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15 ./nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15
docker build -t nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15/build-playground ./nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15/build-playground
docker build -t nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15/build-image ./nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15/build-image
docker build -t nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/build-from-local-repo ./nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/build-from-local-repo

