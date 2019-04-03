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
  args = ["-backend-config='backend.tfvars'"]
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
    args = [
    "-check-variables=true",
    "-var-file=backend.tfvars"
    ]
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
