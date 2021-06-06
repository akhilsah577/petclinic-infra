resource "aws_elb" "web_elb" {
  name    = "${var.prefix}-web-elb"
  subnets = ["${aws_subnet.private.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
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

resource "aws_elb" "mgmt_elb" {
  name    = "${var.prefix}-mgmt-elb"
  subnets = ["${aws_subnet.public.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 8000
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
  instances                   = [aws_instance.mgmt.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "Management-ELB"
  }
}
