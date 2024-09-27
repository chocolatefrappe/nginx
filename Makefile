DOCKER_BAKE_FILE := -f Makefile.docker-bake.hcl
DOCKER_BAKE_TARGET := alpine

DOCKER_META_IMAGES := chocolatefrappe/nginx
DOCKER_META_VERSION := local

build:
	chmod +x rootfs/docker-entrypoint.d/*.sh
	DOCKER_META_IMAGES=$(DOCKER_META_IMAGES) DOCKER_META_VERSION=$(DOCKER_META_VERSION) \
		docker buildx bake $(DOCKER_BAKE_FILE) $(DOCKER_BAKE_TARGET)

run:
	docker run -it --rm -p 8082:8080 -e CLOUDFLARE_ENABLED=true $(DOCKER_META_IMAGES):$(DOCKER_META_VERSION)

.PHONY: test
test:
	cd test && \
	test -f dhparam.pem || \
		openssl dhparam -out dhparam.pem 2048 && \
	docker compose up
