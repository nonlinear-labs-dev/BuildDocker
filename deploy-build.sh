#!/bin/sh

copyonlinehelp="$3"

if [ -z $copyonlinehelp ]
then
	copyonlinehelp="off"
fi

ip="192.168.8.2"
version=`date +"%Y-%m-%d-%H-%M"`
branch="$1"
user="root"
builPath="$2"
targetdir=/nonlinear/playground-$branch-$version

# copy all the stuff into a new directory
if [ "$copyonlinehelp" = 'on' ]
then
	scp -r $2 $user@$ip:$targetdir
elif [ "$copyonlinehelp" = 'off' ]
then
	rsync -av -e ssh --exclude='*/online-help/*' $2 $user@$ip:$targetdir
fi
#if it is a link:
ssh $user@$ip "rm /nonlinear/playground" > /dev/null 2>&1

#if it is a directory (fresh sd card):
ssh $user@$ip "mv /nonlinear/playground /nonlinear/playground-old" > /dev/null 2>&1


# finalize
ssh $user@$ip "ln -s $targetdir /nonlinear/playground"

if [ "$copyonlinehelp" = 'off' ]
then
	ssh $user@$ip "echo 'Not Copied!' > /nonlinear/playground/NonMaps/war/online-help/index.html"
fi

ssh $user@$ip "systemctl restart playground"
