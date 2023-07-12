variable "NGINX_VERSION" {
    default = "stable"
}
variable "S6_OVERLAY_VERSION" {
    default = "v3.1.5.0"
}

group "default" {
    targets = [
        "alpine",
        "debian",
    ]
}

target "docker-metadata-action" {}

target "default-template" {
    context = "."
    args = {
        NGINX_VERSION = "${NGINX_VERSION}"
        S6_OVERLAY_VERSION = "${S6_OVERLAY_VERSION}"
    }
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}

target "alpine" {
    inherits = ["docker-metadata-action", "default-template"]
    dockerfile = "alpine/Dockerfile"
}

target "debian" {
    inherits = ["docker-metadata-action", "default-template"]
    dockerfile = "debian/Dockerfile"
}
