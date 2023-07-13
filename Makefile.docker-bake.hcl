variable "NGINX_VERSION" {
    default = "stable"
}
variable "S6_OVERLAY_VERSION" {
    default = "v3.1.5.0"
}

group "default" {
    targets = [
        "alpine",
    ]
}

variable "DOCKER_META_IMAGES" {}
variable "DOCKER_META_VERSION" {}

target "docker-metadata-action" {
    tags = [
        "${DOCKER_META_IMAGES}:${DOCKER_META_VERSION}"
    ]
}

target "default-template" {
    context = "."
    args = {
        NGINX_VERSION = "${NGINX_VERSION}"
        S6_OVERLAY_VERSION = "${S6_OVERLAY_VERSION}"
        S6_VERBOSITY = "2"
        S6_BEHAVIOUR_IF_STAGE2_FAILS = "0"
    }
}

target "alpine" {
    inherits = ["docker-metadata-action", "default-template"]
    dockerfile = "alpine/Dockerfile"
}

target "debian" {
    inherits = ["docker-metadata-action", "default-template"]
    dockerfile = "debian/Dockerfile"
}
