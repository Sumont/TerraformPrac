output "subnet_ids" {
  description = "List of subnet IDs in different AZs"
  value       = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
}
