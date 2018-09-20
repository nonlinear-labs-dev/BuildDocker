#!/bin/sh

if [ $# -eq 0 ]
   then
       echo "branch name missing"
       exit
fi

echo "Building playground for branch $1"

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
OUTDIR=$SCRIPTPATH/builds/playground/$1/$(date -u +"%G-%m-%d-%H-%M")

echo "OUTDIR: $OUTDIR"
mkdir -p $OUTDIR
./createDockerImages.sh
docker run -v $OUTDIR:/output -ti nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15/build-playground $1



