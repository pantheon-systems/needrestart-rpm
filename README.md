rpm package for needrestart utility
===================================

RPM `.spec` and scripts for creating rpm packages of the `needrestart` util.

Usage
-----

This repo is designed for Circle-CI to do both the RPM builds and pushing
RPM artifacts to package_cloud. The push to package_cloud only happens from the `master` branch.

You can run the RPM builds manually with `make rpm`. Docker is required.

RPMs will be built for multiple versions of Fedora. These are set by the `BUILD_VERSIONS`
environment variable, and can be overridden at runtime. To build only fedora-22:

    $ BUILD_VERSIONS=22 make rpm

You can push the RPMs to package_cloud with `make package_deploy`.

Ensure a `PACKAGECLOUD_TOKEN` env var is set in your local env or on the circle-ci project.
