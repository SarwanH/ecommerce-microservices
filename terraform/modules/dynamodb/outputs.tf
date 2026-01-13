output "cart_table_name" {
  description = "Name of the shopping cart DynamoDB table"
  value       = aws_dynamodb_table.cart.name
}

output "cart_table_arn" {
  description = "ARN of the shopping cart DynamoDB table"
  value       = aws_dynamodb_table.cart.arn
}

output "inventory_table_name" {
  description = "Name of the inventory DynamoDB table"
  value       = aws_dynamodb_table.inventory.name
}

output "inventory_table_arn" {
  description = "ARN of the inventory DynamoDB table"
  value       = aws_dynamodb_table.inventory.arn
}