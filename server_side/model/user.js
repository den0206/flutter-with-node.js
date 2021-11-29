const db = require('../config/config');
const crypto = require('crypto');
const Rol = require('./role');
const {use} = require('passport');

const User = {};

User.getAll = () => {
  const sql = `
    SELECT * FROM users
  `;

  return db.manyOrNone(sql);
};

User.create = (user) => {
  const hashedPassword = crypto
    .createHash('md5')
    .update(user.password)
    .digest('hex');

  user.password = hashedPassword;
  console.log(hashedPassword);

  const sql = `
INSERT INTO
  users(
    email,
    name,
    lastname,
    phone,
    image,
    password,
    created_at,
    updated_at
  )
VALUES
  (
    $1,$2,$3,$4,$5,$6,$7,$8
  ) RETURNING id
  `;

  return db.oneOrNone(sql, [
    user.email,
    user.name,
    user.lastname,
    user.phone,
    user.image,
    user.password,
    new Date(),
    new Date(),
  ]);
};

User.findByPayload = (id, callback) => {
  const sql = `
  SELECT
   *
  FROM
   users
  WHERE
   id = $1
  `;

  return db.oneOrNone(sql, id).then((user) => callback(null, user));
};

User.update = (user) => {
  const sql = `
  UPDATE
    users
  SET
    name = $2,
    lastname = $3,
    phone = $4,
    image = $5,
    updated_at = $6
  WHERE
   id = $1
  `;
  return db.none(sql, [
    user.id,
    user.name,
    user.lastname,
    user.phone,
    user.image,
    new Date(),
  ]);
};

User.findbyEmail = (email) => {
  const sql = `
  SELECT
    U.*,
    json_agg(
        json_build_object(
            'id',
            R.id,
            'name',
            R.name,
            'image',
            R.image,
            'route',
            R.route
        )
    ) AS roles
FROM
    users AS U
    INNER JOIN user_has_roles as UHR ON UHR.user_id = U.id
    INNER JOIN roles as R ON R.id = UHR.role_id
WHERE
    email = $1
GROUP BY
    U.id
  `;
  return db.oneOrNone(sql, email);
};

User.isPasswordMatched = (password, hash) => {
  const hasedpassword = crypto.createHash('md5').update(password).digest('hex');

  if (hasedpassword === hash) {
    return true;
  }

  return false;
};

User.findbyId = (id) => {
  const sql = `
  SELECT
    U.*,
    json_agg(
        json_build_object(
            'id',
            R.id,
            'name',
            R.name,
            'image',
            R.image,
            'route',
            R.route
        )
    ) AS roles
FROM
    users AS U
    INNER JOIN user_has_roles as UHR ON UHR.user_id = U.id
    INNER JOIN roles as R ON R.id = UHR.role_id
WHERE
    U.id = $1
GROUP BY
    U.id
  `;
  return db.oneOrNone(sql, id);
};

User.updateToken = (id, token) => {
  const sql = `
  UPDATE
    users
  SET
    session_token = $2
  WHERE
   id = $1
  `;

  return db.none(sql, [id, token]);
};
module.exports = User;
