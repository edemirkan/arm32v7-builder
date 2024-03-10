# ARM32V7 Builder Podman image

## Installation

With Podman installed, `make shell` builds the arm32v7-builder and drops into a shell inside the container. The container's `~/workspace` is bound to `./workspace` by default.

After building the first time, unless a dependency of the image has changed, `make shell` will skip building and drop into the shell. Running `make shell` from another window while already in a running shell will attach to the already running image.

## Workflow

- On your host machine, clone repositories into `./workspace` and make changes as usual.
- In the container shell, find the repository in `~/workspace` and build as usual.
