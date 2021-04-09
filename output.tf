output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnets_ids" {
  value = data.aws_subnet_ids.available.ids
}

output "public_subnets_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnets_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "db_subnets_ids" {
  value = aws_subnet.db_subnets[*].id
}
output "tags" {
  value = var.tags
}
output "environment" {
  value = var.environment
}
