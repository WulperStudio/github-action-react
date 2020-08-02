.DEFAULT_GOAL := help

include .env
export  $(shell sed 's/=.*//' .env)

# --------------------------------------------------------------------------------- #

build:
	cd /home/htdocs/${PROJECT_NAME} && make build

start:
	cd /home/htdocs/${PROJECT_NAME} && make up

pull:
	cd /home/htdocs/${PROJECT_NAME} && git pull origin ${BRANCH}

down:
	cd /home/htdocs/${PROJECT_NAME} && make down

# --------------------------------------------------------------------------------- #

key_rsa: ## Permission Key RSA
	chmod 400 /root/.ssh/id_rsa

folder: key_rsa ## Create Principal Folder
	cd /home && mkdir htdocs

repository: folder ## Clone Repository
	cd /home/htdocs && git clone ${REPOSITORY}

env-var: repository
	cp /home/.env /home/htdocs/${PROJECT_NAME}

build-init: env-var build ## Build Stack

start-init: build-init start ## Start Stack

# --------------------------------------------------------------------------------- #

update: down pull build start ## Deploy App

# --------------------------------------------------------------------------------- #

help: ## Help Make's Tags
	@printf "\033[31m%-22s %-59s %s\033[0m\n" "Target" " Help"; \
	printf "\033[31m%-22s %-59s %s\033[0m\n"  "------" " ----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-22s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'
