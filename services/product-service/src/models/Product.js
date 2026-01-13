const { pool } = require('../config/database');

class Product {
  // Get all products with optional filters
  static async findAll(filters = {}) {
    let query = 'SELECT * FROM products WHERE 1=1';
    const params = [];
    let paramCount = 1;

    if (filters.category) {
      query += ` AND category = $${paramCount}`;
      params.push(filters.category);
      paramCount++;
    }

    if (filters.minPrice) {
      query += ` AND price >= $${paramCount}`;
      params.push(filters.minPrice);
      paramCount++;
    }

    if (filters.maxPrice) {
      query += ` AND price <= $${paramCount}`;
      params.push(filters.maxPrice);
      paramCount++;
    }

    if (filters.search) {
      query += ` AND (name ILIKE $${paramCount} OR description ILIKE $${paramCount})`;
      params.push(`%${filters.search}%`);
      paramCount++;
    }

    query += ' ORDER BY created_at DESC';

    const result = await pool.query(query, params);
    return result.rows;
  }

  // Get product by ID
  static async findById(id) {
    const result = await pool.query(
      'SELECT * FROM products WHERE id = $1',
      [id]
    );
    return result.rows[0];
  }

  // Get product by SKU
  static async findBySku(sku) {
    const result = await pool.query(
      'SELECT * FROM products WHERE sku = $1',
      [sku]
    );
    return result.rows[0];
  }

  // Create new product
  static async create(productData) {
    const { name, description, price, category, stock, image_url, sku } = productData;
    
    const result = await pool.query(
      `INSERT INTO products (name, description, price, category, stock, image_url, sku)
       VALUES ($1, $2, $3, $4, $5, $6, $7)
       RETURNING *`,
      [name, description, price, category, stock, image_url, sku]
    );
    
    return result.rows[0];
  }

  // Update product
  static async update(id, productData) {
    const { name, description, price, category, stock, image_url } = productData;
    
    const result = await pool.query(
      `UPDATE products 
       SET name = COALESCE($1, name),
           description = COALESCE($2, description),
           price = COALESCE($3, price),
           category = COALESCE($4, category),
           stock = COALESCE($5, stock),
           image_url = COALESCE($6, image_url),
           updated_at = CURRENT_TIMESTAMP
       WHERE id = $7
       RETURNING *`,
      [name, description, price, category, stock, image_url, id]
    );
    
    return result.rows[0];
  }

  // Delete product
  static async delete(id) {
    const result = await pool.query(
      'DELETE FROM products WHERE id = $1 RETURNING *',
      [id]
    );
    return result.rows[0];
  }

  // Update stock
  static async updateStock(id, quantity) {
    const result = await pool.query(
      `UPDATE products 
       SET stock = stock + $1,
           updated_at = CURRENT_TIMESTAMP
       WHERE id = $2
       RETURNING *`,
      [quantity, id]
    );
    return result.rows[0];
  }
}

module.exports = Product;