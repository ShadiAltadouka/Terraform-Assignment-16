output "zone-id" {
    value = aws_route53_zone.private-zone.id
  
}

output "records" {
    value = aws_route53_record.www.records
  
}