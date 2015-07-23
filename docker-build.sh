#!/bin/sh
set -e

# which fedora distros to build this rpm for
BUILD_VERSIONS=${BUILD_VERSIONS:-19 20 22}
echo "==> Running RPM builds for these Fedora version(s): $BUILD_VERSIONS"
echo

CURRENT_DIR="$(dirname "$(readlink -f $0)")"

RUN_ARGS="--rm"
if [ -n "$CIRCLECI" ] ; then
  RUN_ARGS=""
fi

mkdir -p $CURRENT_DIR/{RPMS,SRPMS}

for ver in $BUILD_VERSIONS; do
    echo; echo "==> Building rpm for fedora $ver "
    build_image=quay.io/getpantheon/rpmbuild-fedora:$ver

    docker pull $build_image

    docker run $RUN_ARGS \
        -w /tmp \
        -v $CURRENT_DIR:/tmp \
        -v $CURRENT_DIR/RPMS:/root/rpmbuild/RPMS/ \
        -v $CURRENT_DIR/SRPMS:/root/rpmbuild/SRPMS/ \
        $build_image \
        "/tmp/rpm-build.sh"
done
