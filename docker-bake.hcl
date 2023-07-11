variable "NGINX_VERSION" {
    default = "stable-alpine"
}

target "docker-metadata-action" {}

target "default" {
    inherits = ["docker-metadata-action"]
    dockerfile = "Dockerfile"
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
