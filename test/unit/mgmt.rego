package main

deny[msg] {
  not input.resource.aws_instance.mgmt
  msg = "Management EC2 machine not declared"
}

deny[msg] {
  not input.data.aws_ami.mgmt
  msg = "AMI data not being interpolated"
}

deny[msg] {
  not input.data.template_file.setup_chefserver_script
  msg = "Chef Infra Server provisioning block not templatized"
}

deny[msg] {
  not input.data.template_file.install_jenkins_script
  msg = "Jenkins provisioning block not templatized"
}

deny[msg] {
  not contains(input.template_file.setup_chefserver_script.vars, "chef_server_version")
  msg = "Chef Server version not declared"

}

deny[msg] {
  not contains(input.template_file.setup_chefserver_script.vars, "chef_admin_username")
  msg = "Chef Server admin username not declared"

}

deny[msg] {
  not contains(input.template_file.setup_chefserver_script.vars, "chef_admin_first_name")
  msg = "Chef Server admin first name not declared"

}

deny[msg] {
  not contains(input.template_file.setup_chefserver_script.vars, "chef_admin_last_name")
  msg = "Chef Server admin last name not declared"

}

deny[msg] {
  not contains(input.template_file.setup_chefserver_script.vars, "chef_admin_email")
  msg = "Chef Server email not declared"

}

deny[msg] {
  not contains(input.template_file.setup_chefserver_script.vars, "chef_admin_password")
  msg = "Chef Server admin password not declared"

}

deny[msg] {
  not contains(input.template_file.setup_chefserver_script.vars, "chef_validator_file_name")
  msg = "Chef Server validator not declared"

}

deny[msg] {
  not contains(input.template_file.install_jenkins_script.vars, "jenkins_java_version")
  msg = "Jenkins Java version not defined"
}
