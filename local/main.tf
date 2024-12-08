terraform {
  # using a docker provider for terraform
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }

  # keeping the state local to the repository, no need to go to a S3 Bucket or Azure for something simple
  backend "local" {
    path = "local.tfstate"
  }
}

# this might change on Windows but works fine for Linux and MacOS
# if using podman (instead of docker cli) you need to install podman-helper
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# setting some default values for admins and passwords for the local stuff.
locals {
  default_admin        = "ralves-admin"
  default_password     = "Not-S0-secret-yet-local"
  default_volumes_path = "${path.cwd}/.volumes"
}

# testing things out by creating a PostgreSQL and PGAdmin instances
resource "docker_image" "psql_image" {
  name = "postgres:latest"
}

resource "docker_container" "psql_container" {
  name  = "psql"
  image = docker_image.psql_image.name
  ports {
    internal = 5432
    external = 5432
  }
  env = [
    "POSTGRES_USER=${local.default_admin}",
    "POSTGRES_PASSWORD=${local.default_password}",
    "POSTGRES_DB=\"postgres\"",
    "PGData=\"/var/lib/postgresql/data\""
  ]
  volumes {
    container_path = "/var/lib/postgresql/data"
    host_path      = "${local.default_volumes_path}/psqldata"
  }
}

resource "docker_image" "adminer_image" {
  name = "adminer:latest"
}

# HACK: on MacOs, when specifying the db server in the web ui use host.docker.internal:<psql-port>
resource "docker_container" "adminer_web_ui" {
  name  = "adminer"
  image = docker_image.adminer_image.name
  ports {
    internal = 8080
    external = 8085
  }
}
