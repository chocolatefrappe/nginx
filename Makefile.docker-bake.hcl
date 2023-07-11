variable "NGINX_VERSION" {
    default = "stable-alpine"
}
variable "S6_OVERLAY_VERSION" {
    default = "v3.1.5.0"
}

variable "DOCKER_META_IMAGES" {}
variable "DOCKER_META_VERSION" {}

target "docker-metadata-action" {
    tags = [
        "${DOCKER_META_IMAGES}:${DOCKER_META_VERSION}"
    ]
}

target "default" {
    inherits = ["docker-metadata-action"]
    dockerfile = "Dockerfile"
    context = "."
    args = {
        NGINX_VERSION = "${NGINX_VERSION}"
        S6_OVERLAY_VERSION = "${S6_OVERLAY_VERSION}"
        S6_VERBOSITY = "2"
        S6_BEHAVIOUR_IF_STAGE2_FAILS = "0"
    }
}
