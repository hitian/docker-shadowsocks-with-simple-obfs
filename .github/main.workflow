workflow "Build and push to docker hub" {
  on = "push"
  resolves = ["Push to DockerHub"]
}

action "Login DockerHub" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Build" {
  uses = "docker://docker:stable"
  args = ["build", "-t", "hitian/ss", "."]
}

action "Push to DockerHub" {
  uses = "docker://docker:stable"
  needs = ["Build", "Login DockerHub"]
  args = "push hitian/ss"
}
