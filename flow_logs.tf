data "aws_iam_policy_document" "flow_log_assume" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "vpc-flow-logs.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "flow_log_execution" {
  statement {
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups",
      "logs:CreateLogStream",
      "logs:DescribeLogStrams",
      "logs:PutLogEvents"
    ]
    resources = [
      aws_cloudwatch_log_group.flowlogs.arn
    ]
  }
}

resource "aws_iam_role" "flowlogs" {
  name               = "vpc-flow-logs"
  assume_role_policy = data.aws_iam_policy_document.flow_log_assume.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "flowlogs" {
  name   = "execution"
  role   = aws_iam_role.flowlogs.id
  policy = data.aws_iam_policy_document.flow_log_execution.json
}

resource "aws_flow_log" "main" {
  traffic_type    = "ALL"
  log_destination = aws_cloudwatch_log_group.flowlogs.arn
  iam_role_arn    = aws_iam_role.flowlogs.arn
  vpc_id          = aws_vpc.main.id
}

resource "aws_cloudwatch_log_group" "flowlogs" {
  name              = "vpc-flow-logs"
  retention_in_days = var.flow_log_retention
  tags              = var.tags
}