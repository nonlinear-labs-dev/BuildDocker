FROM nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux

RUN rm -rf /nonlinux/output/build/playground-HEAD
RUN git clone https://github.com/nonlinear-labs-dev/C15.git /nonlinux/output/build/playground-HEAD
RUN git -C /nonlinux/output/build/playground-HEAD checkout master
RUN git -C /nonlinux/output/build/playground-HEAD checkout ./
