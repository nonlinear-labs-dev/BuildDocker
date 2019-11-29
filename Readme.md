##Preresequites
install docker

## Usage
* cd BuildDocker
* ./build-playground.sh `c15-repo-branch`
* connect to C15 wifi
* ./deploy-build.sh `install-name` *builds/playground/`c15-repo-branch`/`latest timestamp`/playground*
* the script will pack, copy to device, unpack, relink */nonlinear/playground* to */nonlinear/`install-name`* and restart the services
