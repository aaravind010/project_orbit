resource "aws_s3_bucket" "orbit_s3_bucket_Static_website" {
  bucket = var.s3_bucket_name
  region = var.region
}

resource "aws_s3_bucket_public_access_block" "nameorbit_s3_bucket_Static_website_pub_acc" {
  bucket = aws_s3_bucket.orbit_s3_bucket_Static_website.id

  block_public_policy     = false
  block_public_acls       = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "s3_index" {
  bucket       = aws_s3_bucket.orbit_s3_bucket_Static_website.id
  key          = "index.html"
  source       = "pages/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "s3_error" {
  bucket       = aws_s3_bucket.orbit_s3_bucket_Static_website.id
  key          = "error.html"
  source       = "pages/error.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "orbit_s3_web_conf" {
  bucket = aws_s3_bucket.orbit_s3_bucket_Static_website.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "orbit_s3_policy" {
  bucket = aws_s3_bucket.orbit_s3_bucket_Static_website.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "${aws_s3_bucket.orbit_s3_bucket_Static_website.arn}/*"
      ]
    }
  ]
}
EOF
}
