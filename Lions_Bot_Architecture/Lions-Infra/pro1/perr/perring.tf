
#### peering configuration #### 


resource "aws_vpc_peering_connection" "this" {
  vpc_id      = var.requester_vpc_id
  peer_vpc_id = var.accpeter_vpc_id
  peer_region = var.accepter_region
  auto_accept = true
}

resource "aws_vpc_peering_connection_accepter" "this1" {
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = true
}


####  route tables ####

resource "aws_route" "requester" {
  route_table_id            = var.route_table_req
  destination_cidr_block    = var.vpc_cidr_req
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "accepter" {
 
  route_table_id            = var.route_table_acc
  destination_cidr_block    = var.vpc_cidr_acc
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  
}