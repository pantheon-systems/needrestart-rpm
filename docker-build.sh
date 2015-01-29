#!/bin/sh
set -e

# which fedora distros to build this rpm for
FEDORA_VERS="19 20"

CURRENT_DIR="$(dirname "$(readlink -f $0)")"

mkdir -p $CURRENT_DIR/{RPMS,SRPMS}

for ver in $FEDORA_VERS; do
    build_image=quay.io/getpantheon/rpmbuild-fedora-$ver

    docker pull $build_image

    docker run --rm \
        -w /tmp \
        -v $CURRENT_DIR:/tmp \
        -v $CURRENT_DIR/RPMS:/root/rpmbuild/RPMS/ \
        -v $CURRENT_DIR/SRPMS:/root/rpmbuild/SRPMS/ \
        $build_image \
        "/tmp/rpm-build.sh"
done
