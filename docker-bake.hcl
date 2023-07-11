variable "NGINX_VERSION" {
    default = "stable-alpine"
}
variable "S6_OVERLAY_VERSION" {
    default = "v3.1.5.0"
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
