output "vpc1-id" {
  value = aws_vpc.vpc1.id
}
output "public1-subnet-id-1" {
  value = aws_subnet.public_subnet1[0].id
}
output "private1-subnet-id-1" {
  value = aws_subnet.private_subnet1[0].id
}
output "public1-subnet-id-2" {
  value = aws_subnet.public_subnet1[1].id
}
output "private1-subnet-id-2" {
  value = aws_subnet.private_subnet1[1].id
}

output "vpc_cidr_acc" {
  value = aws_vpc.vpc1.cidr_block
  
}
output "route_table_acc" {
  value = aws_route_table.publicRT1.id
  
}