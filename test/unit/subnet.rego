package main

deny[msg] {
  not input.resource.aws_subnet.public
  msg = "Public Subnet not declared"
}

deny[msg] {
  not input.resource.aws_subnet.public.map_public_ip_on_launch
  msg = "Public Subnet CIDR Block is not public"
}

deny[msg] {
  not re_match(".*public", input.resource.aws_subnet.public.tags.Name)
  msg = "Public Subnet missing tag `Name`"
}

deny[msg] {
  not contains(input.resource.aws_subnet.public.availability_zone, "data.aws_availability_zones.available")
  msg = "Data resources need to determine availability zone"
}

deny[msg] {
  not input.resource.aws_subnet.private
  msg = "Private Subnet not declared"
}

deny[msg] {
  input.resource.aws_subnet.private.map_public_ip_on_launch
  msg = "Private Subnet CIDR Block is not private"
}

deny[msg] {
  not re_match(".*private", input.resource.aws_subnet.private.tags.Name)
  msg = "Private subnet missing tag `Name`"
}

deny[msg] {
  not contains(input.resource.aws_subnet.public.availability_zone, "data.aws_availability_zones.available")
  msg = "Data resources need to determine availability zone"
}
