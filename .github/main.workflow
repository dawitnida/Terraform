workflow "terraform-docker" {
  resolves = "terraform-plan-docker"
  on = "pull_request"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "terraform-fmt-docker" {
  uses = "hashicorp/terraform-github-actions/fmt@v0.2.0"
  needs = "filter-to-pr-open-synced"
  secrets = [
    "GITHUB_TOKEN",
  ]
  env = {
    TF_ACTION_WORKING_DIR = "docker"
  }
}

action "terraform-init-docker" {
  uses = "hashicorp/terraform-github-actions/init@v0.2.0"
  needs = "terraform-fmt-docker"
  secrets = [
    "GITHUB_TOKEN",
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
  ]
  env = {
    TF_ACTION_WORKING_DIR = "docker"
  }
}

action "terraform-validate-docker" {
  uses = "hashicorp/terraform-github-actions/validate@v0.2.0"
  needs = "terraform-init-docker"
  secrets = [
    "GITHUB_TOKEN",
  ]
  env = {
    TF_ACTION_WORKING_DIR = "docker"
  }
}

action "terraform-plan-docker" {
  uses = "hashicorp/terraform-github-actions/plan@v0.2.0"
  needs = "terraform-validate-docker"
  secrets = [
    "GITHUB_TOKEN",
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
  ]
  env = {
    TF_ACTION_WORKING_DIR = "docker"
    # If you're using Terraform workspaces, set this to the workspace name.
    TF_ACTION_WORKSPACE = "default"
  }
}

workflow "terraform-gcp" {
  resolves = "terraform-plan-gcp"
  on = "pull_request"
}

action "terraform-fmt-gcp" {
  uses = "hashicorp/terraform-github-actions/fmt@<latest tag>"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    TF_ACTION_WORKING_DIR = "gcp"
  }
}

action "terraform-init-gcp" {
  uses = "hashicorp/terraform-github-actions/init@<latest tag>"
  secrets = ["GITHUB_TOKEN"]
  needs = "terraform-fmt-gcp"
  env = {
    TF_ACTION_WORKING_DIR = "gcp"
  }
}

action "terraform-validate-gcp" {
  uses = "hashicorp/terraform-github-actions/validate@<latest tag>"
  secrets = ["GITHUB_TOKEN"]
  needs = "terraform-init-gcp"
  env = {
    TF_ACTION_WORKING_DIR = "gcp"
  }
}

action "terraform-plan-gcp" {
  uses = "hashicorp/terraform-github-actions/plan@<latest tag>"
  needs = "terraform-validate-gcp"
  secrets = ["GITHUB_TOKEN"]
  env = {
    TF_ACTION_WORKING_DIR = "gcp"
  }
}

workflow "terraform-aws/servers" {
  resolves = "terraform-plan-aws/servers"
  on = "pull_request"
}

action "terraform-fmt-aws/servers" {
  uses = "hashicorp/terraform-github-actions/fmt@<latest tag>"
  needs = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
  env = {
    TF_ACTION_WORKING_DIR = "aws/servers"
  }
}

action "terraform-init-aws/servers" {
  uses = "hashicorp/terraform-github-actions/init@<latest tag>"
  secrets = ["GITHUB_TOKEN"]
  needs = "terraform-fmt-aws/servers"
  env = {
    TF_ACTION_WORKING_DIR = "aws/servers"
  }
}

action "terraform-validate-aws/servers" {
  uses = "hashicorp/terraform-github-actions/validate@<latest tag>"
  secrets = ["GITHUB_TOKEN"]
  needs = "terraform-init-aws/servers"
  env = {
    TF_ACTION_WORKING_DIR = "aws/servers"
  }
}

action "terraform-plan-aws/servers" {
  uses = "hashicorp/terraform-github-actions/plan@<latest tag>"
  needs = "terraform-validate-aws/servers"
  secrets = ["GITHUB_TOKEN"]
  env = {
    TF_ACTION_WORKING_DIR = "aws/servers"
  }
}
