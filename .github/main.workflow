workflow "on tag push to master, test and deploy to pub.dev" {
  on = "push"
  resolves = ["deploy"]
}

action "tag-filter" {
  uses = "actions/bin/filter@master"
  args = "tag v*"
}

action "test" {
  uses = "Igor1201/actions/dart-test@master"
  env = {
    DTA_DISABLE_ANALYZER = NO
    DTA_DISABLE_TESTS = NO
  }
  needs = ["tag-filter"]
}

action "deploy" {
  uses = "Igor1201/actions/pub-publish@master"
  secrets = ["PUB_ACCESS_TOKEN", "PUB_REFRESH_TOKEN", "PUB_EXPIRATION"]
  needs = ["test"]
}

workflow "on pull request merge, delete the branch" {
  on = "pull_request"
  resolves = ["branch cleanup"]
}

action "branch cleanup" {
  uses = "jessfraz/branch-cleanup-action@master"
  secrets = ["GITHUB_TOKEN"]
}