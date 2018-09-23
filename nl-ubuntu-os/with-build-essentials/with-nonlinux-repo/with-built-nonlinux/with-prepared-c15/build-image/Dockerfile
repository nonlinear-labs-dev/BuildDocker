FROM nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15

ENTRYPOINT \
	   git -C /nonlinux/output/build/playground-HEAD checkout $0 && \
	   git -C /nonlinux/output/build/playground-HEAD pull origin $0 && \
	   git -C /nonlinux/output/build/playground-HEAD log -n1 && \
	   rm -rf /nonlinux/output/nonlinear/playground && \
	   git -C /nonlinux/output/build/playground-HEAD checkout ./ && \
	   touch /nonlinux/output/build/playground-HEAD/.stamp_downloaded && \
	   touch /nonlinux/output/build/playground-HEAD/.stamp_extracted && \
	   touch /nonlinux/output/build/playground-HEAD/.stamp_patched && \
	   make -C /nonlinux && \
	   cp -R /nonlinux/output/images/rootfs.tar.gz /output
