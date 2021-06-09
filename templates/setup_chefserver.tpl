#!/usr/bin/env bash

#### Description: Script to install and configure Chef Infra Server

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

main(){
	install_wget
        get_chef_server_package
	install_chef_server
	reconfigure_chef_server
	create_admin_user
	create_chef_organization
	reconfigure_chef_server	
}

install_wget(){
	sudo yum install -y wget
}
get_chef_server_package(){
	sudo wget https://packages.chef.io/files/stable/chef-server/${chef_server_version}/el/7/chef-server-core-${chef_server_version}-1.el7.x86_64.rpm -P /tmp/
}

install_chef_server(){
	sudo rpm -Uvh /tmp/chef-server-core-${chef_server_version}-1.el7.x86_64.rpm
}

reconfigure_chef_server(){
	sudo chef-server-ctl reconfigure
}

create_admin_user(){
	sudo chef-server-ctl user-create ${chef_admin_username} ${chef_admin_first_name} ${chef_admin_last_name} ${chef_admin_email} '\"${chef_admin_password}\"' --filename ${chef_validator_file_name}
}

create_chef_organization(){
	sudo chef-server-ctl org-create short_name '\"${chef_organization_name}\"' --association_user ${chef_admin_username} --filename ${chef_organization_name}-validator.pem
}

main "$@"
