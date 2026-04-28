# Repository Guidelines

## Project Structure & Module Organization

This repository defines a Docker-based CI/CD environment for exporting Godot PC games and publishing them with itch.io Butler.

- `Dockerfile` builds the Ubuntu image, installs Godot, export templates, and Butler, then verifies both tools.
- `.github/workflows/docker-publish.yml` builds and pushes Docker images to Docker Hub on `main` pushes and `godot-*` tags.
- `.dockerignore` keeps local metadata and repository-only files out of the Docker build context.
- `README.md` gives the project purpose and supported deployment target.
- `.gitignore` excludes the local `.codex` marker and generated local code folders.

There are no application source files, Godot project files, scripts, or test directories yet. Put reusable helpers in `scripts/` if they are added later.

## Build, Test, and Development Commands

- `docker build -t godot-github-actions .` builds the CI image with default settings.
- `docker build --build-arg GODOT_VERSION=4.6.2 -t godot-github-actions .` builds with a specific Godot version.
- `docker run --rm godot-github-actions godot --headless --version` verifies the Godot binary inside the image.
- `docker run --rm godot-github-actions butler version` verifies Butler inside the image.
- `actionlint .github/workflows/docker-publish.yml` validates the GitHub Actions workflow when `actionlint` is available.

The Docker build downloads external artifacts, so run it after changing version arguments, packages, download URLs, template paths, or symlink paths. For workflow-only changes, validate the workflow and describe the expected Docker Hub tags.

## Coding Style & Naming Conventions

Use uppercase Docker instructions and keep related package installs grouped in one `RUN` block. Prefer `set -eux` for multi-step shell blocks. Indent continued package lists and shell commands with four spaces, matching the existing `Dockerfile`.

Name build arguments with uppercase snake case, such as `GODOT_VERSION` and `BUTLER_PLATFORM`. Keep paths explicit, for example `/opt/godot`, `/opt/butler`, and `/workspace`.

For GitHub Actions, keep workflow names and step names concise and action-oriented. Keep Docker Hub image names in the workflow `env` block, and pass version-specific build arguments from tags named `godot-<version>`.

## Testing Guidelines

There is no formal test suite yet. Treat a successful Docker build as the primary validation. For installed-tool changes, also run the Godot and Butler verification commands above.

For workflow changes, run `actionlint` if available. If scripts are added later, include focused tests or dry-run commands. Name shell helpers descriptively, for example `scripts/build-image.sh`.

## Commit & Pull Request Guidelines

Use concise imperative commit messages, such as `Add Docker image for Godot exports` or `Update Docker publish workflow`.

Pull requests should include:

- A short summary of what changed.
- The Docker build command used for validation.
- Any changed Godot, Ubuntu, Butler, or GitHub Actions versions.
- Linked issues when applicable.

For workflow changes, include expected GitHub Actions behavior, expected image tags, and required Docker Hub configuration.

## Security & Configuration Tips

Do not commit deployment tokens, itch.io API keys, Docker Hub tokens, or game export credentials. Pass secrets through GitHub Actions secrets or runtime environment variables. The Docker publish workflow expects `vars.DOCKERHUB_USERNAME` and `secrets.DOCKERHUB_TOKEN`. Pin versions where practical, and review download URLs when updating external tools.
