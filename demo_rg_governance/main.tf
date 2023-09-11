

locals {
  root_id        = "demo-governance"  # id of the management group on which to apply the resources
  root_name      = "demo-governance"  # name of the management group on which to apply the resources
  root_parent_id = var.root_parent_id # tenant id or management group under which to group the new structure
}


module "caf-enterprise-scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "4.2.0"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  # required input parameters
  default_location = "westeurope"
  root_parent_id   = local.root_parent_id
  root_id          = local.root_id
  root_name        = local.root_name

  # do not send usage data to microsoft
  disable_telemetry = true

  # to use our custom management group structure,
  # we deploy the management group architecture using the custom_landing_zones parameter
  # thus we set the default deployment to false
  custom_landing_zones        = local.custom_landing_zones
  template_file_variables = local.template_file_variables
  deploy_core_landing_zones   = false
  deploy_corp_landing_zones   = false
  deploy_online_landing_zones = false
  # to further customize the management groups and the respective policies applied to it, we will create files in a library folder
  library_path = "${path.root}/lib"


  # we will not deploy the standard management/identity resources from the framework, e.g. log analytics
  deploy_management_resources = false
  deploy_identity_resources   = false
  #   subscription_id_identity     = var.identitySubscriptionId
  #   configure_identity_resources = local.configure_identity_resources


  # we need to see if we want to use the module to deploy the DNS or not
  deploy_connectivity_resources = false
  # subscription in which the private DNS zones are, we need it here for the policies to work correctly
  subscription_id_connectivity = var.connectivity_subscription_id
  #   configure_connectivity_resources = local.configure_connectivity_resources

  # do not manage subscriptions association using the module
  # strict_subscription_association = false
}

