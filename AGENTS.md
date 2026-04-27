# Repository Guidelines

## Project Structure & Module Organization

This repository defines a Docker-based CI/CD environment for exporting Godot PC games and publishing them with itch.io Butler.

- `Dockerfile` builds the Ubuntu image, installs Godot, export templates, and Butler, then verifies both tools.
- `README.md` gives the project purpose and supported deployment target.
- `.gitignore` excludes the local `.codex` marker.

There are no application source files, Godot project files, or test directories yet. Put workflow files in `.github/workflows/` and reusable helpers in `scripts/` if they are added later.

## Build, Test, and Development Commands

- `docker build -t godot-github-actions .` builds the CI image with default settings.
- `docker build --build-arg GODOT_VERSION=4.6.2 -t godot-github-actions .` builds with a specific Godot version.
- `docker run --rm godot-github-actions godot --headless --version` verifies the Godot binary inside the image.
- `docker run --rm godot-github-actions butler version` verifies Butler inside the image.

The build downloads external artifacts, so run it after changing version arguments, packages, download URLs, or symlink paths.

## Coding Style & Naming Conventions

Use uppercase Docker instructions and keep related package installs grouped in one `RUN` block. Prefer `set -eux` for multi-step shell blocks. Indent continued package lists and shell commands with four spaces, matching the existing `Dockerfile`.

Name build arguments with uppercase snake case, such as `GODOT_VERSION` and `BUTLER_PLATFORM`. Keep paths explicit, for example `/opt/godot`, `/opt/butler`, and `/workspace`.

## Testing Guidelines

There is no formal test suite yet. Treat a successful Docker build as the primary validation. For installed-tool changes, also run the Godot and Butler verification commands above.

If scripts or workflows are added later, include focused tests or dry-run commands. Name shell helpers descriptively, for example `scripts/build-image.sh`.

## Commit & Pull Request Guidelines

This repository has no commit history yet, so use concise imperative commit messages, such as `Add Docker image for Godot exports`.

Pull requests should include:

- A short summary of what changed.
- The Docker build command used for validation.
- Any changed Godot, Ubuntu, or Butler versions.
- Linked issues when applicable.

For workflow changes, include expected GitHub Actions behavior and required secrets, such as itch.io credentials.

## Security & Configuration Tips

Do not commit deployment tokens, itch.io API keys, or game export credentials. Pass secrets through GitHub Actions secrets or runtime environment variables. Pin versions where practical, and review download URLs when updating external tools.
