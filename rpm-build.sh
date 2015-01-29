#!/bin/sh
set -e

spec_file='needrestart.spec'

# download and install all RPMs listed as BuildRequires
yum-builddep -y ${spec_file}

# download all Source and Patch files
spectool -g -R ${spec_file}

# build it!!!!
rpmbuild -ba ${spec_file}
