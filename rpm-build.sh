#!/bin/sh
set -ex

spec_file='needrestart.spec'

if [ $(stat -c %U $spec_file) = "UNKNOWN" ]; then
  echo "fixing ownership on $spec_file to avoid rpmbuild errors."
  echo "Someday this will not be necessary when this update sees wider distribution: https://github.com/rpm-software-management/rpm/issues/2 "
  original_uid=$(stat -c %u $spec_file)
  original_gid=$(stat -c %g $spec_file)
  chown nobody:nobody $spec_file
fi

function finish {
  # reset uid:gid if we had to fix it up during the build
  [ "$original_uid" ] && chown $original_uid:$original_gid $spec_file
}
trap finish EXIT

# download and install all RPMs listed as BuildRequires
yum-builddep -y ${spec_file}

# download all Source and Patch files
spectool -g -R ${spec_file}

# build it!!!!
rpmbuild -ba ${spec_file}
