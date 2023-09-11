locals {
  policy_exemptions = {
    "${local.root_id}" = {      # the management group which is the scope of the policy
      Deny-HybridNetworking = [ # the name of the policy/initiative
        # the layer 2 is allowed to have gateways etc.
        "/subscriptions/28bf6993-58c9-4927-81af-618946da865d/resourceGroups/demo-layer-200"
      ]
    }
  }

  mitigations = flatten([
    for scope, exemption in local.policy_exemptions : [
      for policy, resources in exemption : [
        for i, resource in resources : [
          {
            name : "exemption_${scope}_${policy}_${i}"
            resource_id : resource
            policy_assignment_id : "/providers/microsoft.management/managementgroups/${scope}/providers/microsoft.authorization/policyassignments/${policy}"
            is_subscription : length(regexall("/subscriptions/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/?$", resource)) > 0
            is_resource_group : length(regexall("/subscriptions/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/resourceGroups/[^/]*/?$", resource)) > 0
          }
        ]
      ]
    ]
    ]
  )
}

resource "azurerm_resource_policy_exemption" "exemptions" {
  for_each             = { for idx, val in local.mitigations : idx => val if !val.is_subscription && !val.is_resource_group }
  name                 = each.value.name
  resource_id          = each.value.resource_id
  policy_assignment_id = each.value.policy_assignment_id
  exemption_category   = "Mitigated"
}


resource "azurerm_resource_group_policy_exemption" "exemptions" {
  for_each             = { for idx, val in local.mitigations : idx => val if val.is_resource_group }
  name                 = each.value.name
  resource_group_id    = each.value.resource_id
  policy_assignment_id = each.value.policy_assignment_id
  exemption_category   = "Mitigated"
}


