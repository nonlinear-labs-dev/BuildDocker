FROM nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux/with-prepared-c15

ENTRYPOINT \
	   git -C /nonlinux/output/build/playground-layouts-release-build-no-audio fetch && \
	   git -C /nonlinux/output/build/playground-layouts-release-build-no-audio checkout $0 && \
	   git -C /nonlinux/output/build/playground-layouts-release-build-no-audio pull origin $0 && \
	   git -C /nonlinux/output/build/playground-layouts-release-build-no-audio log -n1 && \
	   rm -rf /nonlinux/output/target/nonlinear/playground && \
	   git -C /nonlinux/output/build/playground-layouts-release-build-no-audio checkout ./ && \
	   touch /nonlinux/output/build/playground-layouts-release-build-no-audio/.stamp_downloaded && \
	   touch /nonlinux/output/build/playground-layouts-release-build-no-audio/.stamp_extracted && \
	   touch /nonlinux/output/build/playground-layouts-release-build-no-audio/.stamp_patched && \
	   make -C /nonlinux playground-rebuild && \
	   cp -R /nonlinux/output/target/nonlinear/playground /output && \
	   bash
