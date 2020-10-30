terraform {
  backend "remote" {
    organization = "roadstour"

    workspaces {
      name = "r"
    }
  }
}