# Implement IAM policy to allow the RDS to write logs in the Cloudwatch
resource "aws_iam_role" "rds_enhanced_monitoring" {
  name_prefix        = "${var.database_configuration.db_name}-rds-enhanced-monitoring"
  assume_role_policy = data.aws_iam_policy_document.rds_enhanced_monitoring.json

}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = aws_iam_role.rds_enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"

}

data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}