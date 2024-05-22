resource "aws_route53_zone" "private-zone" {
  name          = "atlas.local"
  force_destroy = true

  vpc {
    vpc_id = var.atlas-vpc
  }

}

resource "aws_route53_record" "www" {
  name    = "atlas.local"
  type    = "A"
  zone_id = aws_route53_zone.private-zone.id
  records = [var.private-ip]
  ttl     = 300

}