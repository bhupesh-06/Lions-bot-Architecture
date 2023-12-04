output "instance_ids" {
  value = [aws_eks_node_group.private-nodes,aws_eks_node_group.private-nodes1 ]
}