variable "DOCKER_META_IMAGES" {}
variable "DOCKER_META_VERSION" {}

target "default" {
    dockerfile = "Dockerfile"
    context = "."
    tags = [
        "${DOCKER_META_IMAGES}:${DOCKER_META_VERSION}"
    ]
}
