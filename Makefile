.PHONY: shell
.PHONY: clean
	
BUILDER_NAME=aveferrum/arm32vf-builder:latest
WORKSPACE_DIR := $(shell pwd)/workspace


CONTAINER_NAME=$(shell docker ps -f "ancestor=$(BUILDER_NAME)" --format "{{.Names}}")
BOLD=$(shell tput bold)
NORM=$(shell tput sgr0)

.build: Dockerfile
	$(info $(BOLD)Setting up qemu...$(NORM))
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	$(info $(BOLD)Building $(BUILDER_NAME)...$(NORM))
	mkdir -p ./workspace
	docker build -t $(BUILDER_NAME) .
	touch .build

ifeq ($(CONTAINER_NAME),)
shell: .build
	$(info $(BOLD)Starting $(BUILDER_NAME)...$(NORM))
	docker run -it --rm -v "$(WORKSPACE_DIR)":/root/workspace $(BUILDER_NAME) /bin/bash
else
shell:
	$(info $(BOLD)Connecting to running $(BUILDER_NAME)...$(NORM))
	docker exec -it $(CONTAINER_NAME) /bin/bash  
endif

clean:
	$(info $(BOLD)Removing $(BUILDER_NAME)...$(NORM))
	docker rmi $(BUILDER_NAME)
	rm -f .build

push:
	$(info $(BOLD)Pushing $(BUILDER_NAME)...$(NORM))
	docker push $(BUILDER_NAME)
