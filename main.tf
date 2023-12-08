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
In the study, rats were exposed to high levels of EMFs for a period of two weeks.  
The results showed that the rats that drank olive leaf tea had significantly less damage to their cells than the rats that did not. 
The study's findings suggest that olive leaf tea may be a helpful way to protect the body from the harmful effects of EMFs.
DESCRIPTION
  domain_name = module.home_oliveleaf_hosting.domain_name
  town = "missingo"
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
A study conducted on the effects of screen time on melatonin levels suggests a correlation between prolonged exposure to electronic screens and a reduction in melatonin production. 
The blue light emitted by screens, especially in the evening, has been found to suppress melatonin release, potentially leading to disruptions in the circadian rhythm and sleep disturbances. 
The study's findings suggest that olive leaf tea may be a helpful way to protect the body from the harmful effects of EMFs.
Incorporating tart cherry juice into one's diet may offer a natural remedy, as it contains melatonin and other sleep-promoting compounds.
The antioxidants and phytochemicals present in tart cherries are believed to support melatonin synthesis and contribute to improved sleep quality. 
It is best to buy fresh tart cherry juice and not from concentrate for higher melatonin content.
DESCRIPTION
  domain_name = module.home_tartcherry_hosting.domain_name
  town = "missingo"
  content_version = var.tartcherry.content_version
}