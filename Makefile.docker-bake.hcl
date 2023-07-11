variable "DOCKER_META_IMAGES" {}
variable "DOCKER_META_VERSION" {}

target "default" {
    dockerfile = "Dockerfile"
    context = "."
    args = {
        S6_VERBOSITY = "2"
        S6_BEHAVIOUR_IF_STAGE2_FAILS = "2"
    }
    tags = [
        "${DOCKER_META_IMAGES}:${DOCKER_META_VERSION}"
    ]
}
