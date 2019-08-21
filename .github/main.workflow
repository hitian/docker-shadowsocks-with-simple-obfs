workflow "Build and push to docker hub" {
  on = "push"
  resolves = ["Push to docker hub"]
}

action "Build" {
  uses = "docker://docker:stable"
  args = ["build", "-t", "hitian/ss", "."]
}

action "Push to docker hub" {
  uses = "docker://docker:stable"
  needs = ["Build"]
  args = "push hitian/ss"
}
