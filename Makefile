unit:
	conftest test -p test/unit/vpc.rego vpc.tf
	conftest test -p test/unit/subnet.rego subnet.tf
	conftest test -p test/unit/igw.rego igw.tf
	conftest test -p test/unit/nat.rego nat.tf
	conftest test -p test/unit/mgmt.rego mgmt.tf
	conftest test -p test/unit/web.rego web.tf
	terraform validate
	terraform fmt

apply:
	terraform apply
