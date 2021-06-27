resource "aws_s3_bucket" "pipeline_artifact_bucket" {
  bucket = "${var.pipeline_artifact_bucket}"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "pipeline_artifact_bucket" {
  bucket = aws_s3_bucket.pipeline_artifact_bucket.id

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_bucket" "mwaa_bucket" {
  bucket = "${var.mwaa_bucket}"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "mwaa_bucket" {
  bucket = aws_s3_bucket.mwaa_bucket.id

  block_public_acls   = true
  block_public_policy = true
}