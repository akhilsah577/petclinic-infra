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

resource "aws_elb" "web_elb" {
  name               = "${var.prefix}-web-elb"
  availability_zones = [data.aws_availability_zones.available.names[0]]
  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }
  instances                   = [aws_instance.web.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "Web-ELB"
  }
}

resource "aws_security_group" "web_sg" {
  name = "${var.prefix}-web-sg"
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
