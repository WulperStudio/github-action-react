.DEFAULT_GOAL := help

include .env
export  $(shell sed 's/=.*//' .env)

build: ## Build Image
	docker build --tag github-action-react:latest .

up: ## Up Container
	docker run -d --rm \
		--name=${PROJECT_NAME} \
		-p 80:4000 \
		--env-file=${PWD}/.env \
		github-action-react:latest \

compile: ## Compile Source
	docker run -it --rm \
		--name=${PROJECT_NAME} \
		-v ${PWD}:/var/app \
		-w /var/app \
		--env-file=${PWD}/.env \
		node:latest \
		npm run build

dev: ## Up Container Mode Dev
	docker run -it --rm \
		--name=${PROJECT_NAME} \
		-p 3001:3000 \
		-v ${PWD}/app:/var/app \
		-w /var/app \
		--env-file=${PWD}/.env \
		node:latest \
		npm run dev

down: ## Down Container
	docker stop ${PROJECT_NAME}

logs: ## Show Logs Container
	docker logs --details --follow --tail="all" ${PROJECT_NAME}

help: ## Help Make's Tags
	@printf "\033[31m%-22s %-59s %s\033[0m\n" "Target" " Help"; \
	printf "\033[31m%-22s %-59s %s\033[0m\n"  "------" " ----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-22s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'
