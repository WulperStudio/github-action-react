init: ## Initialize PLugin
	terraform init

plan: ## Show Infrastructure's Plan
	terraform plan -var-file="vars.tfvars"

apply: ## Create Infrastructure
	terraform apply -var-file="vars.tfvars" -auto-approve

destroy: ## Destroy Infrastructure
	terraform destroy -var-file="vars.tfvars" -auto-approve

help: ## Help Make's Tags
	@printf "\033[31m%-22s %-59s %s\033[0m\n" "Target" " Help"; \
	printf "\033[31m%-22s %-59s %s\033[0m\n"  "------" " ----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-22s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'
