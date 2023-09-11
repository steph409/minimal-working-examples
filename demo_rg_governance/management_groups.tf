locals {
  custom_landing_zones = {
    "${local.root_id}" = {
      display_name               = local.root_name
      parent_management_group_id = local.root_parent_id
      subscription_ids           = [var.subscription_id]
      archetype_config = {
        archetype_id = "customer_env" # default_empty for import
        parameters = {
          "Deploy-AzActivity-Log" : {  # policy name
            "logAnalytics" : "/subscriptions/9d75975a-331c-4ae2-8313-2e32507f60c1/resourceGroups/slcorp-mgmt/providers/Microsoft.OperationalInsights/workspaces/slcorp-la" # policy parameter
          },
          "Deny-Resource-Types": {
            "listOfResourceTypesNotAllowed": [
              "expressRouteCrossConnections" # examplary, this list needs to be written
            ]
          }
          "Deploy-Custom-Route-T": {
            "requiredRoutes": ["10.12.12.5"], # this parameter overwrites the one in the policy assignment
            "vnetRegion": "westeurope", # when we have multiple regions, we can route the traffic to the firewall in the respective region
          }
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
          "Deploy-Custom-Route-T" = false
        }
      }
    }
    #   "${local.root_id}-00006" = {
    #     display_name = "Platform"
    #     parent_management_group_id = local.root_id
    #     subscription_ids = []
    #     archetype_config = {
    #       archetype_id   = "es_platform"
    #       parameters     = {}
    #       access_control = {}
    #     }
    # }
  }
  template_file_variables = {

  }
}