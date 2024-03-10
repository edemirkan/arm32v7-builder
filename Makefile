.PHONY: shell
.PHONY: clean
	
BUILDER_NAME=docker.io/aveferrum/arm32vf-builder:latest
WORKSPACE_DIR := $(shell pwd)/workspace


CONTAINER_NAME=$(shell podman ps -f "ancestor=$(BUILDER_NAME)" --format "{{.Names}}")
BOLD=$(shell tput bold)
NORM=$(shell tput sgr0)

.build: Dockerfile
	$(info $(BOLD)Building $(BUILDER_NAME)...$(NORM))
	mkdir -p ./workspace
	podman build --rm -t $(BUILDER_NAME) .
	touch .build

ifeq ($(CONTAINER_NAME),)
shell: .build
	$(info $(BOLD)Starting $(BUILDER_NAME)...$(NORM))
	podman run -ti --rm -v "$(WORKSPACE_DIR)":/root/workspace $(BUILDER_NAME) /bin/bash
else
shell:
	$(info $(BOLD)Connecting to running $(BUILDER_NAME)...$(NORM))
	podman exec -it $(CONTAINER_NAME) /bin/bash
endif

clean:
	$(info $(BOLD)Removing $(BUILDER_NAME)...$(NORM))
	podman rmi $(BUILDER_NAME)
	rm -f .build

push:
	$(info $(BOLD)Pushing $(BUILDER_NAME)...$(NORM))
	podman push $(BUILDER_NAME)
