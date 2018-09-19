FROM nlbuildtest
RUN apt-get install -y git cmake build-essential wget cpio python unzip bc
CMD cd nonlinux && git checkout nonlinear_2016.05 && make nonlinear_defconfig && make
