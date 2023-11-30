output "vpc-id" {
  value = aws_vpc.vpc.id
}
output "public-subnet-id-1" {
  value = aws_subnet.public_subnet[0].id
}
output "private-subnet-id-1" {
  value = aws_subnet.private_subnet[0].id
}
output "public-subnet-id-2" {
  value = aws_subnet.public_subnet[1].id
}
output "private-subnet-id-2" {
  value = aws_subnet.private_subnet[1].id
}