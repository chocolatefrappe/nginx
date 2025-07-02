variable "NGINX_VERSION" {
    default = "stable"
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
