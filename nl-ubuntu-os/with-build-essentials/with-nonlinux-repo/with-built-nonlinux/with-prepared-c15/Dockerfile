FROM nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux

RUN rm -rf /nonlinux/output/build/playground-layouts-release-build-no-audio
RUN git clone https://github.com/nonlinear-labs-dev/C15.git /nonlinux/output/build/playground-layouts-release-build-no-audio
RUN git -C /nonlinux/output/build/playground-layouts-release-build-no-audio checkout master
RUN git -C /nonlinux/output/build/playground-layouts-release-build-no-audio checkout ./
