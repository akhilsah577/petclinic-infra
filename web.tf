data "aws_ami" "web" {
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

data "template_file" "install_java_script" {
  template = file("${path.module}/templates/install_java.tpl")

  vars = {
    app_java_version = var.app_java_version
  }

}

data "template_cloudinit_config" "web_config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "install_java.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.install_java_script.rendered
  }

}

resource "aws_instance" "web" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.web.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.private.id
  tags = {
    Name  = "${var.prefix}-web"
    Owner = var.owner
  }

  user_data_base64 = data.template_cloudinit_config.web_config.rendered
}
