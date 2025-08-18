DOCKER_BAKE_FILE := -f docker-bake.hcl -f hacks/docker-metadata-action.hcl
DOCKER_BAKE_TARGET := alpine

.EXPORT_ALL_VARIABLES:
DOCKER_META_IMAGES := chocolatefrappe/nginx
DOCKER_META_VERSION := local

print:
	docker buildx bake $(DOCKER_BAKE_FILE) $(DOCKER_BAKE_TARGET) --print

build: rootfs/etc/nginx/conf-available.d/cloudflare.conf
	docker buildx bake $(DOCKER_BAKE_FILE) $(DOCKER_BAKE_TARGET) --load --set="*.platform="

rootfs/etc/nginx/conf-available.d/cloudflare.conf:
	bash scripts/generate-cloudflare-config.sh > rootfs/etc/nginx/conf-available.d/cloudflare.conf
