resource "aws_organizations_account" "main" {
  name                       = var.account_name
  email                      = var.email
  parent_id                  = var.parent_id
  iam_user_access_to_billing = "ALLOW"
  tags                       = var.tags
}