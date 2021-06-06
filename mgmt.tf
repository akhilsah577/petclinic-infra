data "aws_ami" "mgmt" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


data "template_file" "setup_chefserver_script" {
  template = file("${path.module}/templates/setup_chefserver.tpl")

  vars = {
    chef_server_version      = var.chef_server_version
    chef_admin_username      = var.chef_admin_username
    chef_admin_first_name    = var.chef_admin_first_name
    chef_admin_last_name     = var.chef_admin_last_name
    chef_admin_email         = var.chef_admin_email
    chef_admin_password      = var.chef_admin_password
    chef_validator_file_name = var.chef_validator_file_name
    chef_organization_name   = var.chef_organization_name
  }
}

data "template_file" "install_jenkins_script" {
  template = file("${path.module}/templates/install_jenkins.tpl")

  vars = {
    jenkins_java_version = var.jenkins_java_version
  }

}

data "template_cloudinit_config" "mgmt_config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "setup_chefserver.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.setup_chefserver_script.rendered
  }

  part {
    filename     = "install_jenkins.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.install_jenkins_script.rendered
  }

}

resource "aws_instance" "mgmt" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.mgmt.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name        = "${var.prefix}-mgmt"
    Owner       = var.owner
    Description = "Management Server for operational tasks"
  }
  user_data_base64 = data.template_cloudinit_config.mgmt_config.rendered

}
