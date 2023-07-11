DOCKER_BAKE_FILE := -f Makefile.docker-bake.hcl
DOCKER_BAKE_TARGET := default

DOCKER_META_IMAGES := nginx-reverse-proxy
DOCKER_META_VERSION := local

build:
	DOCKER_META_IMAGES=$(DOCKER_META_IMAGES) DOCKER_META_VERSION=$(DOCKER_META_VERSION) \
		docker buildx bake $(DOCKER_BAKE_FILE) $(DOCKER_BAKE_TARGET)

run:
	docker run -it --rm -p 8080:80 $(DOCKER_META_IMAGES):$(DOCKER_META_VERSION)

.PHONY: test
test:
	cd test && \
	docker compose up
