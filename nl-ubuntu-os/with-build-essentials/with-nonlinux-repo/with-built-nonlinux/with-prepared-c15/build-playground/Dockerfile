FROM nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15

ENTRYPOINT \
	   git -C /nonlinux/output/build/playground-HEAD fetch && \
	   git -C /nonlinux/output/build/playground-HEAD checkout $0 && \
	   git -C /nonlinux/output/build/playground-HEAD pull origin $0 && \
	   git -C /nonlinux/output/build/playground-HEAD log -n1 && \
	   rm -rf /nonlinux/output/target/nonlinear/playground && \
	   git -C /nonlinux/output/build/playground-HEAD checkout ./ && \
	   touch /nonlinux/output/build/playground-HEAD/.stamp_downloaded && \
	   touch /nonlinux/output/build/playground-HEAD/.stamp_extracted && \
	   touch /nonlinux/output/build/playground-HEAD/.stamp_patched && \
	   make -C /nonlinux playground-rebuild && \
	   cp -R /nonlinux/output/target/nonlinear/playground /output && \
	   bash
