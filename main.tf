resource "aws_organizations_account" "main" {
  name                       = var.account_name
  email                      = var.email
  parent_id                  = var.parent_id
  iam_user_access_to_billing = "ALLOW"
  tags                       = var.tags
}

resource "aws_organization_policy" "main" {
  count   = enable_account_scp ? 1 : 0
  name    = var.account_name
  content = data.aws_iam_policy_document.scp.json
}

resource "aws_organization_policy_attachment" "main" {
  count     = enable_account_scp ? 1 : 0
  policy_id = aws_organization_policy.main.id
  target_id = aws_organizations_account.main.id
}

data "aws_iam_policy_document" "scp" {
  statement {
    effect = "Deny"
    actions = [
      "ec2:CreateInternetGateway",
      "ec2:AttachInternetGateway",
      "ec2:DeleteInternetGateway",
      "ec2:CreateRouteTable",
      "ec2:CreateRoute",
      "ec2:ReplaceRoute",
      "ec2:AssociateRouteTable",
      "ec2:CreateNetworkAcl",
      "ec2:CreateNetworkAclEntry",
      "ec2:DeleteNetworkAcl",
      "ec2:DeleteNetworkAclEntry",
      "ec2:ReplaceNetworkAclEntry",
      "ec2:ReplaceNetworkAclAssociation",
      "ec2:CreateCarrierGateway",
      "ec2:CreateEgressOnlyInternetGateway",
      "ec2:CreateClientVpn*",
      "ec2:CreateLocalGatewayRoute",
      "ec2:CreateLocalGatewayRouteTableVpcAssociation",
      "ec2:CreateNatGateway",
      "ec2:CreateTransitGateway*",
      "ec2:CreateVpcPeering*",
      "ec2:CreateVpn*",
      "globalaccelerator:Create*",
      "globalaccelerator:Update*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringNotLike"
      variable = "aws:PrincipalARN"
      values   = var.network_admins
    }
  }
}