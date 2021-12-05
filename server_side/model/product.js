const db = require('../config/config');

const Product = {};

Product.create = (product) => {
  const sql = `
    INSERT INTO
    products (
      name,
      description,
      price,
      image1,
      image2,
      image3,
      category_id,
      created_at,
      updated_at
      )
      VALUES
      (
      $1,$2,$3,$4,$5,$6,$7,$8,$9
      ) RETURNING id;
    `;

  return db.oneOrNone(sql, [
    product.name,
    product.description,
    product.price,
    product.image1,
    product.image2,
    product.image3,
    product.category_id,
    new Date(),
    new Date(),
  ]);
};

Product.update = (product) => {
  const sql = `
    UPDATE
      products
    SET
      name = $2,
      description = $3,
      price = $4,
      image1 = $5,
      image2 = $6,
      image3 = $7,
      category_id = $8,
      updated_at = $9
    WHERE
     id = $1
    `;

  return db.none(sql, [
    product.id,
    product.name,
    product.description,
    product.price,
    product.image1,
    product.image2,
    product.image3,
    product.category_id,
    new Date(),
  ]);
};

Product.findbyCategoryId = (category_id) => {
  const sql = `
  SELECT
    P.*
  FROM
    products AS P
  INNER JOIN 
    categories AS C
  ON 
   p.category_id = c.id
  WHERE
    C.id = $1
  `;

  return db.manyOrNone(sql, category_id);
};

module.exports = Product;
