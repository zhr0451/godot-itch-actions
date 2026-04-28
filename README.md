# GitHub Actions CI/CD for Godot to itch.io

This repository contains a Docker image and GitHub Actions workflow for exporting
Godot games and publishing builds to itch.io with Butler.

The `example/` directory is a small Godot project used to demonstrate the CI/CD
pipeline. On every push to `main`, the workflow exports Linux, Windows, and Web
builds from that project and uploads them as GitHub Actions artifacts.

Publishing to itch.io is optional. To enable it for the example workflow, set:

- Repository variable `ITCH_TARGET`, for example `svaika-games/my-game`.
- Repository secret `BUTLER_API_KEY`.

The Web build is archived as `build/web.zip` before publishing, with `index.html`
at the root of the archive.
