output "db_instance_endpoint" {
  description = "Connection endpoint for the database"
  value       = aws_db_instance.postgres.endpoint
}

output "db_instance_address" {
  description = "Address of the database"
  value       = aws_db_instance.postgres.address
}

output "db_instance_name" {
  description = "Name of the database"
  value       = aws_db_instance.postgres.db_name
}

output "db_instance_port" {
  description = "Port of the database"
  value       = aws_db_instance.postgres.port
}

output "db_instance_id" {
  description = "ID of the database instance"
  value       = aws_db_instance.postgres.id
}