# Local Resources

This directory contains docker-compose definitions that are related to my Local Environments.

## Spinning up resources

Use `docker` or `podman` CLIs to spin up compose files in the repo.

For instance were you to run open-webui you should use the following commands:

1. `docker compose -f open-webui.yaml up -d` - to spin up the environment in detached mode
2. `docker compose -f open-webui.yaml down` - to turn off the environment and its resources

For ease of tuning resources most yamls in this repository will use volumes that bind locally to the `.volumes/` directory.
