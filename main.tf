# terraform {
#   required_version = ">= 0.13"
#   required_providers {
#     ibm = {
#       source  = "ibm-cloud/ibm"
#       version = "1.14.0"
#     }
#   }
# }

variable ibmcloud_api_key {
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

resource ibm_resource_group "terraform" {
  name = "terraform"
}

resource ibm_container_cluster "tfcluster" {
  name            = "tfcluster"
  datacenter      = "dal10"
  machine_type    = "b3c.4x16"
  hardware        = "shared"
  public_vlan_id  = "2854312"
  private_vlan_id = "2854314"

  kube_version = "1.17"

  default_pool_size = 3

  public_service_endpoint  = "true"
  private_service_endpoint = "true"

  resource_group_id = ibm_resource_group.terraform.id
}