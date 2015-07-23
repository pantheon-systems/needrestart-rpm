all: package_deploy

clean:
	rm -rf RPMS SRPMS

rpm:
	bash docker-build.sh

circle_deps:
	sudo apt-get install rpm

package_cloud_deps:
	gem install package_cloud

package_deploy: package_cloud_deps rpm
	package_cloud push pantheon/internal/fedora/19 RPMS/x86_64/*fc19*.rpm
	package_cloud push pantheon/internal/fedora/20 RPMS/x86_64/*fc20*.rpm
	package_cloud push pantheon/internal/fedora/22 RPMS/x86_64/*fc22*.rpm

.PHONY: all
