# Godot to itch.io actions

This repository contains a CI pipeline for automatically building and deploying Godot projects.

## Version support

At the moment, only version 4.6.2 is supported. Earlier versions will not be supported. I will only build images for newer engine versions.

The pipeline also supports only **Windows**, **Linux**, and **web builds** of games. Mac support may appear in the future. Mobile version support is not planned.

This tool was built primarily so developers can quickly publish their projects to itch.io while working on jam games or PC releases.

If you use GitLab or need broader support, you are probably better off using [abarichello/godot-ci](https://github.com/abarichello/godot-ci). It supports more platforms, and its main focus is CI with GitLab. My project supports GitHub Actions only.

## Installation and setup

To use the pipeline, first create secrets and variables in your repository.

### Secret setup

To add secrets, go to `Settings > Secrets and variables > Actions > Secrets`.

| Secret | Value |
| ------ | ----- |
| BUTLER_API_KEY | [api key](https://itch.io/docs/butler/login.html) |

This secret is used to log in with Butler and deploy the game to itch.io. To get it:

1. Download [Butler](https://itch.io/docs/butler/installing.html) locally and run `butler login`.
2. Then go to the [API keys](https://itch.io/user/settings/api-keys) page and find the API key with the `wharf` value. Copy that key into the `BUTLER_API_KEY` secret.

### Variable setup

| Variable | Value |
| -------- | ----- |
| ITCH_TARGET | `name/game_name` |

To add variables, go to `Settings > Secrets and variables > Actions > Variables`.

This variable is used to specify the user name and project name for deployment.

To find it, open the project page and take the needed values from the game URL: `https://name.itch.io/game-name`. Then add them as `name/game_name`.

### Pipeline setup

Next, add `.github/workflows/godot-actions.yml` to your repository.

```bash
mkdir -p .github/workflows/
wget -O .github/workflows/godot-actions.yml https://raw.githubusercontent.com/zhr0451/godot-itch-actions/refs/heads/main/godot-actions.yml
```

After that, the workflow should run correctly on every change in the `main` branch.

## Variables

Only Godot 4.6.2 is currently supported. Support for newer versions is planned as they are released. To change how the pipeline works, edit `env`.

```yml
env:
  GODOT_VERSION: 4.6.2
  EXPORT_NAME: project-name
  PROJECT_PATH: .
```

`GODOT_VERSION` points to the engine version;
`EXPORT_NAME` points to the project name;
`PROJECT_PATH` points to the directory that contains `project.godot`.
