FROM nl-ubuntu-os/with-build-essentials/with-nonlinux-repo/with-built-nonlinux

ENV BASE_DIR /nonlinux
ENV TARGET_DIR ${BASE_DIR}/output/target
ENV BUILD_DIR ${BASE_DIR}/output/build/playground-HEAD
ENV STAGING_DIR ${BASE_DIR}/output/staging
ENV HOST_DIR /root/development/buildroot_assets/host
ENV GWT_COMPILER_DIR /root/development/buildroot_assets/host/gwt-2.8.2

RUN mkdir -p /build

CMD cd /build && \
   ${HOST_DIR}/usr/bin/cmake \
   -DPKG_CONFIG_USE_CMAKE_PREFIX_PATH=${HOST_DIR} \
   -DCMAKE_PREFIX_PATH=${HOST_DIR} \
   -DCMAKE_TOOLCHAIN_FILE="${HOST_DIR}/usr/share/buildroot/toolchainfile.cmake" \
   -DCMAKE_COLOR_MAKEFILE=OFF \
   -DBUILD_DOC=OFF \
   -DBUILD_DOCS=OFF \
   -DBUILD_EXAMPLE=OFF \
   -DBUILD_EXAMPLES=OFF \
   -DBUILD_TEST=OFF \
   -DBUILD_TESTS=OFF \
   -DBUILD_TESTING=OFF \
   -DBUILD_SHARED_LIBS=ON \
   -DCMAKE_BUILD_TYPE=Release \
   -DCMAKE_INSTALL_PREFIX="/output" \
   -DJARSDIR="${GWT_COMPILER_DIR}" \
   /c15 && \
   make -j8 && \
   make install