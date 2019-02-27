#!/bin/sh

ip="192.168.8.2"
version=`date +"%Y-%m-%d-%H-%M"`
branch="$1"
buildPath="$2"
targetdir=/nonlinear/playground-$branch-$version
tar=playground-$branch-$version.tar.gz

echo "Generating tar: $tar"

tar -C $buildPath -czf /tmp/$tar ./
ssh root@$ip "mkdir $targetdir"
scp -C /tmp/$tar root@$ip:$targetdir/
ssh root@$ip "gzip -dc $targetdir/$tar | tar -C $targetdir -xf -"

#if it is a link:
ssh root@$ip "rm /nonlinear/playground" > /dev/null 2>&1

#if it is a directory (fresh sd card):
ssh root@$ip "mv /nonlinear/playground /nonlinear/playground-old" > /dev/null 2>&1

# finalize
rm /tmp/$tar
ssh root@$ip "rm $targetdir/$tar"
ssh root@$ip "ln -s $targetdir /nonlinear/playground"
ssh root@$ip "systemctl restart playground"
