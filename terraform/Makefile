# ----------------------------------------------------------------------
#  # Local variables
# ----------------------------------------------------------------------
#  # Current working folder
LCD=$(shell pwd)
DIR_MAIN=$(LCD)
DIR_SCRIPTS=$(LCD)/scripts
DIR_TMP=$(LCD)/tmp

.DEFAULT_GOAL := setup

.PHONY: help
help: ## Display this help
	@echo "Targets:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' Makefile | \
		sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: terraform ## (default) Setup terraform

.PHONY: terraform
terraform: ## Setup terraform
	@$(DIR_SCRIPTS)/setup_terraform.sh

.PHONY: cpu_plan
cpu_plan: ## Terraform plan CPU instance
	@bin/terraform plan -state=envs/cpu/fastai-dl.tfstate -var-file=envs/cpu/fastai-dl.tfvars envs/cpu/

.PHONY: cpu_apply
cpu_apply: ## Terraform apply CPU instance
	@bin/terraform apply -state=envs/cpu/fastai-dl.tfstate -var-file=envs/cpu/fastai-dl.tfvars envs/cpu/

.PHONY: cpu_destroy
cpu_destroy: ## Terraform destroy CPU instance
	@bin/terraform destroy -state=envs/cpu/fastai-dl.tfstate -var-file=envs/cpu/fastai-dl.tfvars envs/cpu/

.PHONY: gpu_plan
gpu_plan: ## Terraform plan GPU instance
	@bin/terraform plan -state=envs/gpu/fastai-dl.tfstate -var-file=envs/gpu/fastai-dl.tfvars envs/gpu/

.PHONY: gpu_apply
gpu_apply: ## Terraform apply GPU instance
	@bin/terraform apply -state=envs/gpu/fastai-dl.tfstate -var-file=envs/gpu/fastai-dl.tfvars envs/gpu/

.PHONY: gpu_destroy
gpu_destroy: ## Terraform destroy GPU instance
	@bin/terraform destroy -state=envs/gpu/fastai-dl.tfstate -var-file=envs/gpu/fastai-dl.tfvars envs/gpu/
