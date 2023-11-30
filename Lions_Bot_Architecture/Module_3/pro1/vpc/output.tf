output "vpc1-id" {
  value = aws_vpc.vpc1.id
}
output "public-subnet-id-11" {
  value = aws_subnet.public_subnet1[0].id
}
output "private-subnet-id-11" {
  value = aws_subnet.private_subnet1[0].id
}
output "public-subnet-id-21" {
  value = aws_subnet.public_subnet1[1].id
}
output "private-subnet-id-21" {
  value = aws_subnet.private_subnet1[1].id
}
output "route_table_acc" {
  value = aws_route_table.publicRT1.id
  
}
output "vpc1_cidr" {
  value = aws_vpc.vpc1.cidr_block
  
}

