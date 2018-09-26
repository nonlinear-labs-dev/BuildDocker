#!/bin/sh

if [ $# -eq 0 ]
   then
       echo "branch name missing"
       exit
fi

echo "Building c15 image for branch $1"

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
OUTDIR=$SCRIPTPATH/builds/rootfs/$1/$(date +"%G-%m-%d-%H-%M")

echo "OUTDIR: $OUTDIR"
mkdir -p $OUTDIR
./createDockerImages.sh
docker run -v $OUTDIR:/output -ti nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15/build-image $1



