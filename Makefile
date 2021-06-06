TFPLAN = .tfplan
unit:
	conftest test -p test/unit/vpc.rego vpc.tf
	conftest test -p test/unit/subnet.rego subnet.tf
	conftest test -p test/unit/igw.rego igw.tf
	conftest test -p test/unit/nat.rego nat.tf
	conftest test -p test/unit/mgmt.rego mgmt.tf
	conftest test -p test/unit/web.rego web.tf
	conftest test -p test/unit/securitygroup.rego securitygroup.tf
	conftest test -p test/unit/elb.rego elb.tf
	conftest test -p test/unit/nacl.rego nacl.tf
	terraform validate
	terraform fmt
contract:
	terraform plan -out $(TFPLAN) -var-file=terraform.tfvars
	terraform show -json $(TFPLAN) > $(TFPLAN).json
	conftest test -p test/contract/verify.rego $(TFPLAN).json

apply:
	terraform apply
clean:  
	terraform destroy --force  || true
	rm $(TFPLAN) $(TFPLAN).json || true
