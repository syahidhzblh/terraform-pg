terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.40.0"
    }
  }
}

provider "github" {
  token = ""
}

resource "github_repository" "my-repo" {
  name        = "test-repo-tf"
  description = "Test create repo from terrafrom"

  visibility = "public"
}
