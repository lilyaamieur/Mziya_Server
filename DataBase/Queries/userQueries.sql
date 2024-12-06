INSERT INTO users (name, email, password, phone, address,gender, profile_picture, national_id, verified)
VALUES (:name, :email, :password, :phone, :address,:gender, :profile_picture, :national_id, :verified)
RETURNING id;
--select users by attributes
SELECT * FROM users WHERE id = :id;
SELECT * FROM users WHERE name = :name;
SELECT * FROM users WHERE email = :email;
SELECT * FROM users WHERE phone = :phone;
SELECT * FROM users WHERE address = :address;
SELECT * FROM users WHERE gender = :gender;
SELECT * FROM users WHERE national_id = :national_id;
SELECT * FROM users WHERE verified = :verified;
SELECT * FROM users WHERE profile_picture = :profile_picture;

-- update users
-- Update User by ID
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address ,gender=:gender, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE id = :id;

-- Update User by Name
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address ,gender=:gender, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE name = :name;

-- Update User by Email
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address ,gender=:gender, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE email = :email;

-- Update User by Phone
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address ,gender=:gender, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE phone = :phone;

-- Update User by Address
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address ,gender=:gender, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE address = :address;

-- Update User by National ID
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address ,gender=:gender, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE national_id = :national_id;

-- Update User by Verified Status
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address ,gender=:gender, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE verified = :verified;

-- Update User by Profile Picture
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address ,gender=:gender, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE profile_picture = :profile_picture;

-- Update User by Creation Date
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address ,gender=:gender, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE created_at = :created_at;

-- Update User by Update Date
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address ,gender=:gender, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE updated_at = :updated_at;
--delete user
-- Delete User by ID
DELETE FROM users WHERE id = :id;

-- Delete User by Name
DELETE FROM users WHERE name = :name;

-- Delete User by Email
DELETE FROM users WHERE email = :email;

-- Delete User by Phone
DELETE FROM users WHERE phone = :phone;

-- Delete User by Address
DELETE FROM users WHERE address = :address;

-- Delete User by National ID
DELETE FROM users WHERE national_id = :national_id;

-- Delete User by Verified Status
DELETE FROM users WHERE verified = :verified;

-- Delete User by Profile Picture
DELETE FROM users WHERE profile_picture = :profile_picture;
-- Delete User by gende 
DELETE FROM users WHERE gender = :gender;
