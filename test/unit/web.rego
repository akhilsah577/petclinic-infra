package main

deny[msg] {
  not input.resource.aws_instance.web
  msg = "Web EC2 machine not declared"
}

deny[msg] {
  not input.data.aws_ami.web
  msg = "AMI data not being interpolated"
}

deny[msg] {
  not input.data.template_file.install_java_script
  msg = "Provisioning block for installing Java missing"
}

deny[msg] {
  not input.data.template_file.install_java_script.vars.app_java_version
  msg = "Java version not parameterized"
}
