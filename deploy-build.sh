#!/bin/sh

ip="192.168.8.2"
version=`date +"%Y-%m-%d-%H-%M"`
branch="$1"
builPath="$2"
targetdir=/nonlinear/playground-$branch-$version

# copy all the stuff into a new directory
scp -r $2 root@$ip:$targetdir

#if it is a link:
ssh root@$ip "rm /nonlinear/playground" > /dev/null 2>&1

#if it is a directory (fresh sd card):
ssh root@$ip "mv /nonlinear/playground /nonlinear/playground-old" > /dev/null 2>&1

# finalize
ssh root@$ip "ln -s $targetdir /nonlinear/playground"
ssh root@$ip "systemctl restart playground"
