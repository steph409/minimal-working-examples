locals {
  custom_landing_zones = {
    "${local.root_id}" = {
      display_name               = local.root_name
      parent_management_group_id = local.root_parent_id
      subscription_ids           = [var.subscription_id]
      archetype_config = {
        archetype_id = "customer_env" # default_empty for import
        parameters = {
          "Deny-Resource-Locations" : {  # policy name
            "listOfAllowedLocations" : [ # policy parameter
              "eastus",
              "eastus2",
              "westus",
              "northcentralus",
              "southcentralus"
            ]
          },
        }
        access_control = {}
        enforcement_mode = {
          "Deploy-AzActivity-Log"    = false
          "Enforce-GR-KeyVault"      = false
          "Enforce-TLS-SSL"          = false
          "Deny-HybridNetworking"    = false
          "Deny-Public-Endpoints"    = false
          "Deny-Public-IP-On-NIC"    = false
          "Deploy-Private-DNS-Zones" = false
        }
      }
    }
  }
}