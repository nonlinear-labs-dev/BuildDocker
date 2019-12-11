#!/bin/sh

function runShell() {
    PREPARE_COMMANDS="export HOME=/workdir/ccache"
    docker run -u $(id -u ${USER}):$(id -g ${USER}) --rm -it -v ${WORKDIR}:/workdir ${DOCKERNAME} bash -c "$PREPARE_COMMANDS && $1"
    return $?
}

function quit() {
    echo $1

    if [ -n "$STARTSHELL"]; then 
        runShell "bash"
    fi

    exit 1
}

while getopts ":w:c:b:s:" opt; do
    case $opt in
        w) WORKDIR=$(readlink -f "$OPTARG")
        ;;
        c) C15DIR=$(readlink -f "$OPTARG")
        ;;
        b) BRANCH="$OPTARG"
        ;;
        b) STARTSHELL="1"
        ;;
        \?) quit "Invalid option -$OPTARG"
        ;;
    esac
done

function parseOpts() {
    echo "Workdir: $WORKDIR"
    echo "C15dir: $C15DIR"
    echo "Branch: $BRANCH"

    DOCKERNAME=nl-ubuntu-os/with-build-essentials/${USER}
    DOCKER_GROUP_ID=`getent group docker | cut -d: -f3`
    USER_ID=`id -u $USER`
}

function checkPreconditions() {
    echo ${FUNCNAME[0]}
    if [ -n "$C15DIR" ] && [ -n "$BRANCH" ]; then
        quit "You cannot sepcify local c15 dir and branch the same time!"
    fi

    if [ -z "$C15DIR" ] && [ -z "$BRANCH" ]; then
        quit "You have to sepcify either local c15 dir (-c) or branch (-b)!"
    fi

    if [ -z "$WORKDIR" ]; then
        quit "You have to sepcify the working directory (-w)!"
    fi
}

function checkoutNonlinux() {
    echo ${FUNCNAME[0]}
    if [ ! -d "$WORKDIR/nonlinux" ]; then
        git -C "$WORKDIR" clone git@github.com:nonlinear-labs-dev/nonlinux.git || quit "Could not clone nonlinux repo!"
    fi
    git -C "$WORKDIR/nonlinux" checkout nonlinear_2016.05 || quit "Could not checkout branch 'nonlinear_2016.05' in nonlinux repo!"
}

function prepareBuild() {
    echo ${FUNCNAME[0]}
    if [ -f "$WORKDIR/nonlinux/output/images/rootfs.tar.gz" ] && [ -d "$WORKDIR/nonlinux/output/build/playground-HEAD" ]; then
        echo "Build looks already prepared, skipping..."
        return 0
    fi

    docker build -t nl-ubuntu-os ./nl-ubuntu-os || quit "Could not build nl-ubuntu-os"
    docker build --build-arg user=${USER} --build-arg user_id=${USER_ID} --build-arg docker_group_id=${DOCKER_GROUP_ID} -t ${DOCKERNAME} ./nl-ubuntu-os/with-build-essentials || quit "Could not build ${DOCKERNAME}"

    COMMANDS="cd /workdir/nonlinux && \
              make nonlinear_defconfig && \
              make"

    runShell "$COMMANDS" || quit "Could not do preparing build in docker." 
}

function injectC15Dir() {
    echo ${FUNCNAME[0]}
    shopt -s dotglob
    rsync --exclude 'CMakeCache.txt' \
          --exclude 'CMakeFiles' \
          --exclude 'CMakeFiles/*' \
          --exclude 'cmake_install.cmake' \
          --exclude 'install_manifest.txt' \
          --exclude 'NonMaps/obj/*' \
          --exclude 'NonMaps/war/*' \
          -av --delete $C15DIR/* $WORKDIR/nonlinux/output/build/playground-HEAD/
}

function injectC15Branch() {
    echo ${FUNCNAME[0]}
    if [ ! -d "$WORKDIR/C15" ]; then
        git -C "$WORKDIR" clone git@github.com:nonlinear-labs-dev/C15.git || quit "Could not clone C15 repo!"
    fi 
    
    git -C "$WORKDIR/C15" checkout $BRANCH || quit "Could not checkout branch '$BRANCH' in C15 repo!"

    C15DIR="$WORKDIR/C15" 
    injectC15Dir
}

function doFinalBuild() {
    echo ${FUNCNAME[0]}
    COMMANDS="cd /workdir/nonlinux && \
            make playground-clean-for-reconfigure && \
            make playground-rebuild && \
            make"

    runShell "$COMMANDS" || quit "Could not do final build step in docker." 
}

main() {
    echo ${FUNCNAME[0]}
    parseOpts
    checkPreconditions
    checkoutNonlinux
    prepareBuild
    
    if [ -n "$C15DIR" ]; then
        injectC15Dir
    fi

    if [ -n "$BRANCH" ]; then
        injectC15Branch
    fi

    doFinalBuild
      
    echo "Everything worked perfectly. Your stuff is in ${WORKDIR}/nonlinux/output/target."

    if [ -n "$STARTSHELL"]; then 
        runShell "bash  "
    fi 
    exit 0
}

main