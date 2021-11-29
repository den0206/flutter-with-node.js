DROP TABLE IF EXISTS rolse CASCADE;

CREATE TABLE roles(
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(180) NOT NULL UNIQUE,
    image VARCHAR(255) NULL,
    route VARCHAR(255) NULL,
    created_at TIMESTAMP(0) NOT NULL,
    updated_at TIMESTAMP(0) NOT NULL
);


DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    phone VARCHAR(80) NOT NULL UNIQUE,
    image VARCHAR(255) NULL,
    password VARCHAR(255) NOT NULL,
    is_available BOOLEAN NULL,
    session_token VARCHAR(255) NULL,
    created_at TIMESTAMP(0) NOT NULL,
    updated_at TIMESTAMP(0) NOT NULL
);

DROP TABLE IF EXISTS user_has_roles CASCADE;

CREATE TABLE user_has_roles(
    user_id BIGSERIAL NOT NULL,
    role_id BIGSERIAL NOT NULL,
    created_at TIMESTAMP(0) NOT NULL,
    updated_at TIMESTAMP(0) NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(role_id) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(user_id, role_id)
)






INSERT INTO
    roles (
        name,
        route,
        created_at,
        updated_at
    )
VALUES
    (
        'CLIENT',
        'client/products/list',
        '2021-05-22',
        '2021-05-22'
    );

INSERT INTO
    roles (
        name,
        route,
        created_at,
        updated_at
    )
VALUES
    (
        'RESTAURANTE',
        'restaurant/orders/list',
        '2021-05-22',
        '2021-05-22'
    );

INSERT INTO
    roles (
        name,
        route,
        created_at,
        updated_at
    )
VALUES
    (
        'DRIVER',
        'driver/products/list',
        '2021-05-22',
        '2021-05-22'
    );


SELECT
   U.* ,
  
json_agg(
	json_build_object(
	'id',R.id,
    'name', R.name,
    'image', R.image,
    'route' , R.route
	)
   
)

   

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
    )
FROM
    users AS U
    INNER JOIN user_has_roles as UHR ON UHR.user_id = U.id
    INNER JOIN roles as R ON R.id = UHR.role_id
WHERE
    email = 'aaaa@a.com'
GROUP BY
    U.id