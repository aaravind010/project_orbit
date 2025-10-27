output "s3_static_endpoint" {
  value = aws_s3_bucket.orbit_s3_bucket_Static_website.website_endpoint
}