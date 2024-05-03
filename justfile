# by default list available targets

IMAGE_BASE:="deepdogdocker"

default:
	just --list --justfile {{justfile()}}

# release the app, checking that our working tree is clean and ready for release, optionally takes target version
release version="":
	#!/usr/bin/env bash
	set -euxo pipefail
	if [[ -n "{{version}}" ]]; then
		./scripts/release.sh {{version}}
	else
		./scripts/release.sh
	fi

# Build a local image, probably not good to push it.
build:
	docker build -t {{IMAGE_BASE}}:local .

# Runs the built image, assumes a build via the build command
run *args:
	docker run --rm {{IMAGE_BASE}}:local {{args}}

# Runs the built image, assumes a build via the build command, override python as entrypoint
run-entry entrypoint *args:
	docker run --rm --entrypoint {{entrypoint}} {{IMAGE_BASE}}:local {{args}}

# Runs the built image, hops into bash
run-bash:
	docker run --rm --entrypoint /bin/bash -it {{IMAGE_BASE}}:local

poetry-add target:
	poetry -C src add --lock {{target}}@latest
