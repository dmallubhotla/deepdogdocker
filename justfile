# by default list available targets

REGISTRY_URL:="local.dmallubhotla/"
IMAGE_BASE:="deepdogdocker"

default:
	just --list --justfile {{justfile()}}

# release the app, checking that our working tree is clean and ready for release
release:
	./scripts/release.sh

# Build a local image, probably not good to push it.
build:
	docker build -t {{REGISTRY_URL}}{{IMAGE_BASE}}:local .

# Runs the built image, assumes a build via the build command
run *args:
	docker run {{REGISTRY_URL}}{{IMAGE_BASE}}:local {{args}}

# Runs the built image, assumes a build via the build command, override python as entrypoint
run-entry entrypoint *args:
	docker run --entrypoint {{entrypoint}} {{REGISTRY_URL}}{{IMAGE_BASE}}:local {{args}}
