output "instance_ids1" {
  value = [aws_eks_node_group.private1-nodes,aws_eks_node_group.private1-nodes1 ]
}