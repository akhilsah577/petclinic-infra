#!/usr/bin/env bash

#### Description: Script to install and configure Chef Infra Server

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

main(){
	get_chef_server_package
	install_chef_server
	reconfigure_chef_server
	create_admin_user
	create_chef_organization
	reconfigure_chef_server	
}


get_chef_server_package(){
	wget https://packages.chef.io/files/stable/chef-server/14.4.4/el/7/chef-server-core-14.4.4-1.el7.x86_64.rpm
}

install_chef_server(){
	sudo rpm -Uvh /tmp/chef-server-core-14.4.4-1.el7.x86_64.rpm
}

reconfigure_chef_server(){
	sudo chef-server-ctl reconfigure
}

create_admin_user(){
	sudo chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL 'PASSWORD' --filename FILE_NAME
}

create_chef_organization(){
	sudo chef-server-ctl org-create short_name 'full_organization_name' --association_user user_name --filename ORGANIZATION-validator.pem
}

main "$@"
