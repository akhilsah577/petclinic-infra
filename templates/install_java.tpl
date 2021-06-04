#!/usr/bin/env bash

#### Description: Script to install and configure Java

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

main(){
	update_yum_packages
	install_java
}

update_yum_packages(){
	sudo yum -y update
}

install_java(){
	sudo yum install -y ${app_java_version}
}

main "$@"
