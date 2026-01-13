# DynamoDB Table for Shopping Cart
resource "aws_dynamodb_table" "cart" {
  name         = "${var.project_name}-cart"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user_id"
  range_key    = "session_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "session_id"
    type = "S"
  }

  # TTL for automatic cleanup of old carts
  ttl {
    attribute_name = "ttl"
    enabled        = true
  }

  # Point-in-time recovery for data protection
  point_in_time_recovery {
    enabled = true
  }

  # Server-side encryption
  server_side_encryption {
    enabled = true
  }

  tags = {
    Name = "${var.project_name}-cart-table"
  }
}

# DynamoDB Table for Product Inventory (optional but useful)
resource "aws_dynamodb_table" "inventory" {
  name         = "${var.project_name}-inventory"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "product_id"

  attribute {
    name = "product_id"
    type = "S"
  }

  # Global Secondary Index for querying by SKU
  global_secondary_index {
    name            = "sku-index"
    hash_key        = "sku"
    projection_type = "ALL"
  }

  attribute {
    name = "sku"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = {
    Name = "${var.project_name}-inventory-table"
  }
}