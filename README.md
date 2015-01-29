rpm package for needrestart utility
===================================

RPM `.spec` and scripts for creating rpm packages of the `needrestart` util.

Building RPM
------------

Run the `docker-build.sh` script which will take the following actions:

1. pull down a docker image pre-populated with dev tools and rpm
  build tools.
2. execute `rpm-build.sh` inside the container
  to identify this is a Pantheon-forked package.
3. on success, `.rpm`'s will be in the `RPMS` dir and `.src.rpm`'s will be in `SRPMS`
