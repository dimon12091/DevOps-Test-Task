output "private_subnets_id" {
  value       = toset ([
     for private-subnet in aws_subnet.private : private-subnet.id
  ])
  description = "Private subnets Arn"
}

output "public_subnets_id" {
  value       = toset ([
     for public-subnet in aws_subnet.public : public-subnet.id
  ])
  description = "Public subnets Arn"
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}