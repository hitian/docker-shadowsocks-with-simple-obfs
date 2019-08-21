workflow "Build and push to docker hub" {
  on = "push"
  resolves = [ "Push docker image to docker hub" ]
}

action "Build docker image" {
  uses = "docker://docker:stable"
  args = [ "build", "-t", "hitian/ss", "."]
}

action "Push docker image to docker hub" {
  uses = "docker://docker:stable"
  needs = [ "Build docker image" ]
  args = "push hitian/ss"
}

