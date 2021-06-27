resource "aws_mwaa_environment" "test_mwaa" {
  dag_s3_path        = "dags/"
  execution_role_arn = aws_iam_role.mwaa_role.arn
  name               = "test_mwaa"

  network_configuration {
    security_group_ids = [aws_security_group.mwaa_security_group.id]
    subnet_ids         = [data.aws_subnet.private_subnet.id, data.aws_subnet.private_subnet1.id]
  }

  source_bucket_arn = aws_s3_bucket.mwaa_bucket.arn
}