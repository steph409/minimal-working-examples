variable "root_parent_id" {
  description = "The tenant id or management group under which to group the new structure"
  type        = string
}

variable "connectivity_subscription_id" {
  description = "The subscription id in which the private DNS zones are, we need it here for the policies to work correctly"
  type        = string
}
variable "subscription_id" {
  description = "The subscription id in which the policy information is stored"
  type        = string
}