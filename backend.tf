terraform {
  cloud {
    organization = "xtc-ansy"

    workspaces {
      name = "ansy-project"
    }
  }
}