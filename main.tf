terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
    organization = "projects-awscloudgirl"
    workspaces {
      name = "terra-house-tech-wellness"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_oliveleaf_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.oliveleaf.public_path
  content_version = var.oliveleaf.content_version
}

resource "terratowns_home" "home" {
  name = "Olive Leaf Tea"
  description = <<DESCRIPTION
Olive leaf tea may offer protection against the harmful effects of WiFi and electromagnetic fields (EMFs).
DESCRIPTION
  domain_name = module.home_oliveleaf_hosting.domain_name
  town = "cooker-cove"
  content_version = var.oliveleaf.content_version
}

module "home_tartcherry_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.tartcherry.public_path
  content_version = var.tartcherry.content_version
}

resource "terratowns_home" "home_tartcherry" {
  name = "Tart Cherry Juice"
  description = <<DESCRIPTION
Tart cherry juice has gained attention for its potential to boost melatonin levels, a hormone crucial for regulating sleep-wake cycles.
DESCRIPTION
  domain_name = module.home_tartcherry_hosting.domain_name
  town = "cooker-cove"
  content_version = var.tartcherry.content_version
}