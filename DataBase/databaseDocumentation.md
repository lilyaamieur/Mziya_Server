# Mzia Database Documentation

## Table of Contents

1. Overview
2. Getting Started
3. Database Structure
4. Access and Security
5. Common Operations
6. Troubleshooting
7. Maintenance
8. Version History

## 1. Overview

### Purpose

The Mzia platform database is designed to manage relationships between service providers (home owners) and workers for home services, such as babysitting, plumbing, gardening, etc. It facilitates job posting, worker applications, contract creation, payments, reviews, and notifications

### Technology Stack

- Database Type: PostgreSQL
- Version: 1.0
- Host Environment: Cloud provider (NodeChef)

## 2. Getting Started

### Prerequisites

- Required software :PostgreSQL
- System requirements : Cloud-hosted PostgreSQL
- Access credentials needed :
  Host: [hostname]
  Port: [port number]
  Database Name: [database name]
  Username: [username]
  Password: [password]

### Installation Steps

1. Step-by-step installation guide :
   -Set up PostgreSQL database on your cloud host.
   -Create the required tables using the SQL schema provided in the database structure section.
2. Configuration settings:Configure connection settings in your application to the PostgreSQL database
3. Initial setup process :Test the connection and perform initial queries.
   4-Creating ENUM Types
   PostgreSQL allows ENUM types to represent predefined values. For the Mzia database:

```sql
CREATE TYPE job_type AS ENUM ('small_task', 'large_task');
CREATE TYPE job_status AS ENUM ('pending', 'in_progress', 'completed', 'cancelled');
CREATE TYPE job_category AS ENUM ('Babysitting', 'Child Care', 'Plumberie', 'Gardening');
CREATE TYPE application_status AS ENUM ('pending', 'accepted', 'rejected');
CREATE TYPE payment_status AS ENUM ('pending', 'completed', 'failed');
CREATE TYPE payment_method AS ENUM ('card', 'cash', 'wallet');
CREATE TYPE notification_type AS ENUM ('assigment_update', 'job_offer', 'message', 'application');

```

### Connection Details

```
    Host: [hostname]
    Port: [port number]
    Database Name: [database name]
    Username: [username]
    Password: [password]
```

## 3. Database Structure

### Schema Overview

The database is organized into several tables representing the primary entities involved in the platform: users, jobs, job applications, job contracts, payments, reviews, ratings, and notifications. It also includes ENUM types to categorize job types, status, categories, and payment methods.

### Tables/Collections

For each table/collection:

### Users Table

| Column Name     | Data Type    | Description Constraints       |
| --------------- | ------------ | ----------------------------- | --------------- |
| id              | SERIAL       | Unique identifier for user    | PRIMARY KEY     |
| name            | VARCHAR(255) | Name of the user              | NOT NULL        |
| email           | VARCHAR(255) | User's email address          | UNIQUE NOT NULL |
| password        | VARCHAR(255) | Encrypted password            | NOT NULL        |
| phone           | VARCHAR(15)  | User's phone number           | NULL,NOT NULL   |
| address         | TEXT         | User's home address           | NULL            |
| profile_picture | BYTEA        | Profile picture               | NULL            |
| national_id     | VARCHAR(20)  | User's national ID (optional) | NULL            |
| verified        | BOOLEAN      | Whether the user is verified  | DEFAULT FALSE   |
| created_at      | TIMESTAMP    | Account creation timestamp    | DEFAULT NOW()   |
| updated_at      | TIMESTAMP    | Last updated timestamp        | DEFAULT NOW()   |

### Jobs Table

| Column Name   | Data Type    | Description                        | Constraints            |
| ------------- | ------------ | ---------------------------------- | ---------------------- |
| id            | SERIAL       | Unique identifier for job post     | PRIMARY KEY            |
| home_owner_id | INT          | Reference to the home_owner        | FOREIGN KEY (users.id) |
| description   | TEXT         | Job description                    | NULL                   |
| location      | VARCHAR(255) | Job location                       | NULL                   |
| job_type      | job_type     | Type of the job (small/large task) | ENUM                   |
| job_category  | job_category | Job category                       | ENUM                   |
| budget        | INT          | Budget set for the job             | NULL                   |
| status        | job_status   | Current status of the job          | DEFAULT 'pending'      |
| created_at    | TIMESTAMP    | Job creation timestamp             | DEFAULT NOW()          |
| updated_at    | TIMESTAMP    | Last updated timestamp             | DEFAULT NOW()          |

### Home Owner Table

| Column Name | Data Type         | Description                   | Constraints            |
| ----------- | ----------------- | ----------------------------- | ---------------------- |
| job_id      | INT               | Job post reference            | FOREIGN KEY (jobs.id)  |
| user_id     | INT               | User reference for home owner | FOREIGN KEY (users.id) |
| PRIMARY KEY | (job_id, user_id) | Composite primary key         |                        |

### Job Applications Table

| Column Name      | Data Type          | Description                       | Constraints               |
| ---------------- | ------------------ | --------------------------------- | ------------------------- |
| id               | SERIAL             | Unique identifier for application | PRIMARY KEY               |
| job_id           | INT                | Reference to job                  | FOREIGN KEY (jobs.id)     |
| worker_id        | INT                | Reference to worker               | FOREIGN KEY (users.id)    |
| application_date | TIMESTAMP          | Date of application               | DEFAULT CURRENT_TIMESTAMP |
| status           | application_status | Status of application             | DEFAULT 'pending'         |
| created_at       | TIMESTAMP          | Creation timestamp                | DEFAULT CURRENT_TIMESTAMP |
| updated_at       | TIMESTAMP          | Last update timestamp             | DEFAULT CURRENT_TIMESTAMP |

### Workers Table

| Column Name    | Data Type                 | Description                  | Constraints                       |
| -------------- | ------------------------- | ---------------------------- | --------------------------------- |
| application_id | INT                       | Reference to job application | FOREIGN KEY (job_applications.id) |
| user_id        | INT                       | Reference to worker          | FOREIGN KEY (users.id)            |
| skills         | TEXT[]                    | Array of worker's skills     | NULL                              |
| PRIMARY KEY    | (application_id, user_id) | Composite primary key        |                                   |

### Job Contracts Table

| Column Name        | Data Type | Description                      | Constraints                       |
| ------------------ | --------- | -------------------------------- | --------------------------------- |
| id                 | SERIAL    | Unique identifier for contract   | PRIMARY KEY                       |
| job_id             | INT       | Reference to job                 | FOREIGN KEY (jobs.id)             |
| application_id     | INT       | Reference to job application     | FOREIGN KEY (job_applications.id) |
| user_worker_id     | INT       | Reference to worker (user)       | FOREIGN KEY (users.id)            |
| user_home_owner_id | INT       | Reference to home owner (user)   | FOREIGN KEY (users.id)            |
| acceptation_date   | TIMESTAMP | Date of contract acceptance      | DEFAULT CURRENT_TIMESTAMP         |
| start_date         | TIMESTAMP | Job start date                   | NULL                              |
| end_date           | TIMESTAMP | Job end date                     | NULL                              |
| payment_id         | INT       | Reference to payment             | FOREIGN KEY (payments.id)         |
| terms              | TEXT      | Terms and conditions for the job | NULL                              |
| conditions         | TEXT      | Additional conditions            | NULL                              |
| created_at         | TIMESTAMP | Contract creation timestamp      | DEFAULT CURRENT_TIMESTAMP         |

### Payments Table

| Column Name      | Data Type      | Description                       | Constraints                   |
| ---------------- | -------------- | --------------------------------- | ----------------------------- |
| id               | SERIAL         | Unique identifier for payment     | PRIMARY KEY                   |
| job_contract_id  | INT            | Reference to job contract         | FOREIGN KEY (job_contract.id) |
| payment_status   | payment_status | Status of the payment             | DEFAULT 'pending'             |
| amount           | DECIMAL(10, 2) | Payment amount                    | NULL                          |
| payment_method   | payment_method | Payment method (card/cash/wallet) | DEFAULT 'card'                |
| transaction_date | TIMESTAMP      | Date of transaction               | DEFAULT NOW()                 |

### Notifications Table

| Column Name       | Data Type         | Description                        | Constraints               |
| ----------------- | ----------------- | ---------------------------------- | ------------------------- |
| id                | SERIAL            | Unique identifier for notification | PRIMARY KEY               |
| user_id           | INT               | Reference to user                  | FOREIGN KEY (users.id)    |
| notification_text | TEXT              | Content of the notification        | NULL                      |
| notification_type | notification_type | Type of notification               | ENUM                      |
| read_status       | BOOLEAN           | Whether the notification is read   | DEFAULT FALSE             |
| created_at        | TIMESTAMP         | Notification creation timestamp    | DEFAULT CURRENT_TIMESTAMP |

### Reviews tables

### Reviews Homeowner Table

| Column Name  | Data Type     | Description                        | Constraints                         |
| ------------ | ------------- | ---------------------------------- | ----------------------------------- |
| id           | SERIAL        | Unique identifier for review       | PRIMARY KEY                         |
| assigment_id | INT           | Reference to job contract          | FOREIGN KEY (job_contract.id)       |
| reviewer_id  | INT           | Reference to reviewer (home owner) | FOREIGN KEY (users.id)              |
| rating       | DECIMAL(3, 2) | Rating score (0-5)                 | CHECK (rating >= 0 AND rating <= 5) |
| review_text  | TEXT          | Review content                     | NULL                                |
| created_at   | TIMESTAMP     | Review creation timestamp          | DEFAULT CURRENT_TIMESTAMP           |

### Reviews Worker Table

| Column Name  | Data Type     | Description                    | Constraints                         |
| ------------ | ------------- | ------------------------------ | ----------------------------------- |
| id           | SERIAL        | Unique identifier for review   | PRIMARY KEY                         |
| assigment_id | INT           | Reference to job contract      | FOREIGN KEY (job_contract.id)       |
| reviewer_id  | INT           | Reference to reviewer (worker) | FOREIGN KEY (users.id)              |
| rating       | DECIMAL(3, 2) | Rating score (0-5)             | CHECK (rating >= 0 AND rating <= 5) |
| review_text  | TEXT          | Review content                 | NULL                                |
| created_at   | TIMESTAMP     | Review creation timestamp      | DEFAULT CURRENT_TIMESTAMP           |

### Rating Tables

#### Worker Rating Table

| Column Name   | Data Type     | Description                           | Constraints                         |
| ------------- | ------------- | ------------------------------------- | ----------------------------------- |
| id            | SERIAL        | Unique identifier for the rating      | PRIMARY KEY                         |
| assignment_id | INT           | Reference to the job contract         | FOREIGN KEY (job_contract.id)       |
| reviewer_id   | INT           | Reference to the reviewer (homeowner) | FOREIGN KEY (users.id)              |
| rating        | DECIMAL(3, 2) | Rating score (0-5)                    | CHECK (rating >= 0 AND rating <= 5) |
| review_text   | TEXT          | Review content                        | NULL                                |
| created_at    | TIMESTAMP     | Rating creation timestamp             | DEFAULT CURRENT_TIMESTAMP           |

#### Homeowner Rating Table

| Column Name   | Data Type     | Description                        | Constraints                         |
| ------------- | ------------- | ---------------------------------- | ----------------------------------- |
| id            | SERIAL        | Unique identifier for the rating   | PRIMARY KEY                         |
| assignment_id | INT           | Reference to the job contract      | FOREIGN KEY (job_contract.id)       |
| reviewer_id   | INT           | Reference to the reviewer (worker) | FOREIGN KEY (users.id)              |
| rating        | DECIMAL(3, 2) | Rating score (0-5)                 | CHECK (rating >= 0 AND rating <= 5) |
| review_text   | TEXT          | Review content                     | NULL                                |
| created_at    | TIMESTAMP     | Rating creation timestamp          | DEFAULT CURRENT_TIMESTAMP           |

### Table Creation Scripts

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- encrypted password
    --role ENUM('worker', 'home_owner') NOT NULL, -- to differentiate between clients and service providers
    phone VARCHAR(15) UNIQUE NOT NULL,
    address TEXT,
    profile_picture BLOB,
    national_id VARCHAR(20) --optional
    verified BOOLEAN DEFAULT FALSE, -- whether the user is verified or not
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    home_owner_id INT REFERENCES users(id) ON DELETE CASCADE, -- home owner
    description TEXT,
    location VARCHAR(255),
    job_type job_type ,
    job_category  NOT NULL,
    budget INT,
    status job_status DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE home_owner (
    job_id INT REFERENCES jobs(id) ON DELETE CASCADE, -- foreign key reference to job post
    user_id INT REFERENCES users(id) ON DELETE CASCADE, -- foreign key reference to users
    PRIMARY KEY (job_id, user_id) -- composite primary key
);
CREATE TABLE job_applications (
    id SERIAL PRIMARY KEY,
    job_id INT REFERENCES jobs(id) ON DELETE CASCADE, -- from job_id we can get the home_owner id
    worker_id INT REFERENCES users(id) ON DELETE CASCADE, --worker
    application_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status application_status DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE workers (
    application_id INT REFERENCES job_applications(id) ON DELETE CASCADE, -- foreign key reference to job application
    user_id INT REFERENCES users(id) ON DELETE CASCADE, -- foreign key reference to users
    PRIMARY KEY (application_id, user_id) -- composite primary key
    skills TEXT[],  -- array of skills worker offers
);
CREATE TABLE job_contract (
    id SERIAL PRIMARY KEY,
    job_id INT REFERENCES jobs(id) ON DELETE CASCADE,
    application_id INT job_applications(id) ON DELETE CASCADE, -- part of the   worker_id
    user_worker_id INT NOT NULL,    --should i do it FOREIGN KEY users(id) ON DELETE CASCADE  -- part of the   worker_id
    FOREIGN KEY (application_id, user_worker_id) REFERENCES workers(application_id, user_id) ON DELETE CASCADE --worker id is foreign key
    user_home_owner_id INT NOT NULL, --should i do it FOREIGN KEY users(id) ON DELETE CASCADE part of the home_owner_id
    FOREIGN KEY (job_id, user_home_owner_id) REFERENCES home_owner(job_id, user_id) ON DELETE CASCADE, --home owner id is foreign key
    acceptation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, --accept the application
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    payment_id INT REFERENCES payments(id) ON DELETE CASCADE,
    terms TEXT,
    conditions TEXT,  -- terms and conditions for the contract
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);
-- the home owner assign the work
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    job_contract_id INT REFERENCES job_contract(id),
    payment_status  DEFAULT 'pending',
    amount DECIMAL(10, 2),
    payment_method  DEFAULT 'card',
    transaction_date TIMESTAMP DEFAULT NOW()
);
CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    notification_text TEXT,
    notification_type ,
    read_status BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE reviews_worker (
    id INT PRIMARY KEY,
    assigment_id INT REFERENCES job_contract(id) ON DELETE CASCADE,
    reviewer_id INT REFERENCES job_contract(user_home_owner_id) ON DELETE CASCADE,
    rating DECIMAL(3, 2) CHECK (rating >= 0 AND rating <= 5),  -- Rating out of 5
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE rating_homeowner(
    id SERIAL PRIMARY KEY,
    assigment_id INT REFERENCES job_contract(id) ON DELETE CASCADE,
    reviewer_id INT REFERENCES job_contract(user_home_owner_id) ON DELETE CASCADE,
    rating DECIMAL(3, 2) CHECK (rating >= 0 AND rating <= 5),  -- Rating out of 5
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reviews_worker (
    id INT PRIMARY KEY,
    assigment_id INT REFERENCES job_contract(id) ON DELETE CASCADE,
    reviewer_id INT REFERENCES job_contract( user_worker_id) ON DELETE CASCADE,
    rating DECIMAL(3, 2) CHECK (rating >= 0 AND rating <= 5),  -- Rating out of 5
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE rating_worker(
    id SERIAL PRIMARY KEY,
    assigment_id INT REFERENCES job_contract(id) ON DELETE CASCADE,
    reviewer_id INT REFERENCES job_contract( user_worker_id) ON DELETE CASCADE,
    rating DECIMAL(3, 2) CHECK (rating >= 0 AND rating <= 5),  -- Rating out of 5
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Relationships

-A user can be either a home_owner or a worker or both

- If a user post a job then he is a home owner
- If a user apply for a job then he is a worker
  -Each job is posted by a home_owner.
  -The home owner can accept , reject the job application of a worker.
  -Each job can have multiple job applications from different workers.
  -Each worker can apply for multiple jobs.
  -Upon accepting a worker, a job_contract is created between the home_owner and the worker.
  -Payments are made through job_contract and tracked in the payments table
  -Payments can be made cashe or through cards or wallet
- A user can reseive four types of notifications 'assigment_update', 'job_offer', 'message', 'application'
  *assigment_update is sent to worker when a home_owner updates the status of a job application
  *job_offer is sent to worker when a home_owner post a job
  *message is sent to user when a user sends a message to another user
  *application is sent to home_owner when a worker applies for a job
  -Reviews and ratings are given after contract completion for both home_owners and workers.
  *A home owner can give a rating to a worker after the job is completed.
  *A worker can give a rating to a home owner after the job is completed.
  *A home owner can give a review to a worker after the job is completed.
  *A worker can give a review to a home owner after the job is completed.

## 4. Access and Security

### User Roles

- Admin: Full access to all tables and CRUD operations.
- Home Owner: Access to job posting, viewing applications, payment processing, and review/ratings , contract details
- Worker: Access to job applications, contract details, reviews/ratings.

### Authentication Process

-User logs in with phone number, email and password.
-Password is validated against the users table (hashed/encrypted).

### Backup Procedures

- Backup schedule:Daily backups are scheduled at midnight. using pg_dump command.
- Backup location : Cloud-based storage (e.g., AWS S3, Google Cloud). -- not sure here
- Recovery process :Restore from backup using pg_restore command.

## 5. Common Operations

### Querying Data

### Adding Data

```sql
--  user
INSERT INTO users (name, email, password, phone, address, profile_picture, national_id, verified)
VALUES (:name, :email, :password, :phone, :address, :profile_picture, :national_id, :verified)
RETURNING id;
-- job
INSERT INTO jobs (home_owner_id, description, location, job_type, job_category, budget, status)
VALUES (:home_owner_id, :description, :location, :job_type, :job_category, :budget, :status)
RETURNING id;
-- job_application
INSERT INTO job_applications (job_id, worker_id, application_date, status)
VALUES (:job_id, :worker_id, :application_date, :status)
RETURNING id;
--job_contract
INSERT INTO job_contract (job_id, application_id, user_worker_id, user_home_owner_id, acceptation_date, start_date, end_date, payment_id, terms, conditions)
VALUES (:job_id, :application_id, :user_worker_id, :user_home_owner_id, :acceptation_date, :start_date, :end_date, :payment_id, :terms, :conditions)
RETURNING id;

--home_owner
INSERT INTO home_owner (job_id, user_id)
VALUES (:job_id, :user_id);

-- workers
INSERT INTO workers (application_id, user_id, skills)
VALUES (:application_id, :user_id, :skills);
--payments
INSERT INTO payments (job_contract_id, payment_status, amount, payment_method, transaction_date)
VALUES (:job_contract_id, :payment_status, :amount, :payment_method, :transaction_date)
RETURNING id;

--notifications
INSERT INTO notifications (user_id, notification_text, notification_type, read_status)
VALUES (:user_id, :notification_text, :notification_type, :read_status)
RETURNING id;

--reviews_homeowner
INSERT INTO reviews_worker (id, assigment_id, reviewer_id, rating, review_text)
VALUES (:id, :assigment_id, :reviewer_id, :rating, :review_text)
RETURNING id;

--rating_homeowner
INSERT INTO rating_homeowner (assigment_id, reviewer_id, rating)
VALUES (:assigment_id, :reviewer_id, :rating)
RETURNING id;

--reviews_worker
INSERT INTO reviews_worker (id, assigment_id, reviewer_id, rating, review_text)
VALUES (:id, :assigment_id, :reviewer_id, :rating, :review_text)
RETURNING id;
--rating_worker
INSERT INTO rating_worker (assigment_id, reviewer_id, rating)
VALUES (:assigment_id, :reviewer_id, :rating)
RETURNING id;


```

### Select Data

```sql
--user
--select users by attributes
SELECT * FROM users WHERE id = :id;
SELECT * FROM users WHERE name = :name;
SELECT * FROM users WHERE email = :email;
SELECT * FROM users WHERE phone = :phone;
SELECT * FROM users WHERE address = :address;
SELECT * FROM users WHERE national_id = :national_id;
SELECT * FROM users WHERE verified = :verified;
SELECT * FROM users WHERE profile_picture = :profile_picture;
-----------------------------------------------------------------------
-- job--
-- 1. Select Job by ID
SELECT * FROM jobs WHERE id = :id;

-- 2. Select Job by Home Owner ID
SELECT * FROM jobs WHERE home_owner_id = :home_owner_id;

-- 3. Select Job by Description
SELECT * FROM jobs WHERE description = :description;

-- 4. Select Job by Location
SELECT * FROM jobs WHERE location = :location;

-- 5. Select Job by Job Type
SELECT * FROM jobs WHERE job_type = :job_type;

-- 6. Select Job by Job Category
SELECT * FROM jobs WHERE job_category = :job_category;

-- 7. Select Job by Budget
SELECT * FROM jobs WHERE budget = :budget;

-- 8. Select Job by Status
SELECT * FROM jobs WHERE status = :status;

-- 9. Select Job by Creation Date
SELECT * FROM jobs WHERE created_at = :created_at;

-- 10. Select Job by Update Date
SELECT * FROM jobs WHERE updated_at = :updated_at;
------------------------------------------------
-- job_application
-- Select Job Applications by ID
SELECT * FROM job_applications WHERE id = :id;

-- Select Job Applications by Job ID
SELECT * FROM job_applications WHERE job_id = :job_id;

-- Select Job Applications by Worker ID
SELECT * FROM job_applications WHERE worker_id = :worker_id;

-- Select Job Applications by Application Date
SELECT * FROM job_applications WHERE application_date = :application_date;

-- Select Job Applications by Status
SELECT * FROM job_applications WHERE status = :status;

-- Select Job Applications by Creation Date
SELECT * FROM job_applications WHERE created_at = :created_at;

-- Select Job Applications by Update Date
SELECT * FROM job_applications WHERE updated_at = :updated_at;

----------------------------------------------------
--job_contract
-- Select Job Contract by ID
SELECT * FROM job_contract WHERE id = :id;

-- Select Job Contract by Job ID
SELECT * FROM job_contract WHERE job_id = :job_id;

-- Select Job Contract by Application ID
SELECT * FROM job_contract WHERE application_id = :application_id;

-- Select Job Contract by Worker User ID
SELECT * FROM job_contract WHERE user_worker_id = :user_worker_id;

-- Select Job Contract by Home Owner User ID
SELECT * FROM job_contract WHERE user_home_owner_id = :user_home_owner_id;

-- Select Job Contract by Start Date
SELECT * FROM job_contract WHERE start_date = :start_date;

-- Select Job Contract by End Date
SELECT * FROM job_contract WHERE end_date = :end_date;

-- Select Job Contract by Payment ID
SELECT * FROM job_contract WHERE payment_id = :payment_id;

-- Select Job Contract by Creation Date
SELECT * FROM job_contract WHERE created_at = :created_at;
----------------------------------------------------
--home_owner
-- Select Home Owner by Job ID
SELECT * FROM home_owner WHERE job_id = :job_id;
-- Select Home Owner by User ID
SELECT * FROM home_owner WHERE user_id = :user_id;
---------------------------------------------------------------
-- workers
-- Select Workers by Application ID
SELECT * FROM workers WHERE application_id = :application_id;

-- Select Workers by User ID
SELECT * FROM workers WHERE user_id = :user_id;

-- Select Workers by Skills
SELECT * FROM workers WHERE skills @> ARRAY[:skill]; -- Matches workers with a specific skill
---------------------------------------------------------------
--payments
-- Select Payments by ID
SELECT * FROM payments WHERE id = :id;

-- Select Payments by Job Contract ID
SELECT * FROM payments WHERE job_contract_id = :job_contract_id;

-- Select Payments by Status
SELECT * FROM payments WHERE payment_status = :payment_status;

-- Select Payments by Amount
SELECT * FROM payments WHERE amount = :amount;

-- Select Payments by Payment Method
SELECT * FROM payments WHERE payment_method = :payment_method;

-- Select Payments by Transaction Date
SELECT * FROM payments WHERE transaction_date = :transaction_date;
------------------------------------------------------------------
--notifications
-- Select Notifications by ID
SELECT * FROM notifications WHERE id = :id;

-- Select Notifications by User ID
SELECT * FROM notifications WHERE user_id = :user_id;

-- Select Notifications by Type
SELECT * FROM notifications WHERE notification_type = :notification_type;

-- Select Notifications by Read Status
SELECT * FROM notifications WHERE read_status = :read_status;

-- Select Notifications by Creation Date
SELECT * FROM notifications WHERE created_at = :created_at;
-------------------------------------------------------------------
--reviews_worker
-- Select Reviews Worker by ID
SELECT * FROM reviews_worker WHERE id = :id;

-- Select Reviews Worker by Assignment ID
SELECT * FROM reviews_worker WHERE assigment_id = :assigment_id;

-- Select Reviews Worker by Reviewer ID
SELECT * FROM reviews_worker WHERE reviewer_id = :reviewer_id;

-- Select Reviews Worker by Rating
SELECT * FROM reviews_worker WHERE rating = :rating;

-- Select Reviews Worker by Creation Date
SELECT * FROM reviews_worker WHERE created_at = :created_at;
-------------------------------------------------------------------
--rating_worker
-- Select Rating Worker by Assignment ID
SELECT * FROM rating_worker WHERE assigment_id = :assigment_id;

-- Select Rating Worker by Reviewer ID
SELECT * FROM rating_worker WHERE reviewer_id = :reviewer_id;

-- Select Rating Worker by Rating
SELECT * FROM rating_worker WHERE rating = :rating;

-- Select Rating Worker by Creation Date
SELECT * FROM rating_worker WHERE created_at = :created_at;
-----------------------------------------------------------------
--reviews_homeowner
-- Select Rating Homeowner by Assignment ID
SELECT * FROM rating_homeowner WHERE assigment_id = :assigment_id;

-- Select Rating Homeowner by Reviewer ID
SELECT * FROM rating_homeowner WHERE reviewer_id = :reviewer_id;

-- Select Rating Homeowner by Rating
SELECT * FROM rating_homeowner WHERE rating = :rating;

-- Select Rating Homeowner by Creation Date
SELECT * FROM rating_homeowner WHERE created_at = :created_at;
---------------------------------------------------------------------------
--rating_homeowner
-- Select Rating Homeowner by Assignment ID
SELECT * FROM rating_homeowner WHERE assigment_id = :assigment_id;

-- Select Rating Homeowner by Reviewer ID
SELECT * FROM rating_homeowner WHERE reviewer_id = :reviewer_id;

-- Select Rating Homeowner by Rating
SELECT * FROM rating_homeowner WHERE rating = :rating;

-- Select Rating Homeowner by Creation Date
SELECT * FROM rating_homeowner WHERE created_at = :created_at;

```

### Modifying Data

```sql
-- user
-- Update User by ID
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE id = :id;

-- Update User by Name
UPDATE users
SET email = :email, password = :password, phone = :phone, address = :address, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE name = :name;

-- Update User by Email
UPDATE users
SET name = :name, password = :password, phone = :phone, address = :address, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE email = :email;

-- Update User by Phone
UPDATE users
SET name = :name, email = :email, password = :password, address = :address, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE phone = :phone;

-- Update User by Address
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, profile_picture = :profile_picture, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE address = :address;

-- Update User by National ID
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address, profile_picture = :profile_picture, verified = :verified, updated_at = NOW()
WHERE national_id = :national_id;

-- Update User by Verified Status
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address, profile_picture = :profile_picture, national_id = :national_id, updated_at = NOW()
WHERE verified = :verified;

-- Update User by Profile Picture
UPDATE users
SET name = :name, email = :email, password = :password, phone = :phone, address = :address, national_id = :national_id, verified = :verified, updated_at = NOW()
WHERE profile_picture = :profile_picture;


--job


-- 1. Update Job by ID
UPDATE jobs
SET home_owner_id = :home_owner_id,
    description = :description,
    location = :location,
    job_type = :job_type,
    job_category = :job_category,
    budget = :budget,
    status = :status,
    updated_at = NOW()
WHERE id = :id;

-- 2. Update Job by Home Owner ID
UPDATE jobs
SET id = :id,
    description = :description,
    location = :location,
    job_type = :job_type,
    job_category = :job_category,
    budget = :budget,
    status = :status,
    updated_at = NOW()
WHERE home_owner_id = :home_owner_id;

-- 3. Update Job by Description
UPDATE jobs
SET id = :id,
    home_owner_id = :home_owner_id,
    location = :location,
    job_type = :job_type,
    job_category = :job_category,
    budget = :budget,
    status = :status,
    updated_at = NOW()
WHERE description = :description;

-- 4. Update Job by Location
UPDATE jobs
SET id = :id,
    home_owner_id = :home_owner_id,
    description = :description,
    job_type = :job_type,
    job_category = :job_category,
    budget = :budget,
    status = :status,
    updated_at = NOW()
WHERE location = :location;

-- 5. Update Job by Job Type
UPDATE jobs
SET id = :id,
    home_owner_id = :home_owner_id,
    description = :description,
    location = :location,
    job_category = :job_category,
    budget = :budget,
    status = :status,
    updated_at = NOW()
WHERE job_type = :job_type;

-- 6. Update Job by Job Category
UPDATE jobs
SET id = :id,
    home_owner_id = :home_owner_id,
    description = :description,
    location = :location,
    job_type = :job_type,
    budget = :budget,
    status = :status,
    updated_at = NOW()
WHERE job_category = :job_category;

-- 7. Update Job by Budget
UPDATE jobs
SET id = :id,
    home_owner_id = :home_owner_id,
    description = :description,
    location = :location,
    job_type = :job_type,
    job_category = :job_category,
    status = :status,
    updated_at = NOW()
WHERE budget = :budget;

-- 8. Update Job by Status
UPDATE jobs
SET id = :id,
    home_owner_id = :home_owner_id,
    description = :description,
    location = :location,
    job_type = :job_type,
    job_category = :job_category,
    budget = :budget,
    updated_at = NOW()
WHERE status = :status;

-- 9. Update Job by Creation Date
UPDATE jobs
SET id = :id,
    home_owner_id = :home_owner_id,
    description = :description,
    location = :location,
    job_type = :job_type,
    job_category = :job_category,
    budget = :budget,
    status = :status,
    updated_at = NOW()
WHERE created_at = :created_at;

-- 10. Update Job by Update Date
UPDATE jobs
SET id = :id,
    home_owner_id = :home_owner_id,
    description = :description,
    location = :location,
    job_type = :job_type,
    job_category = :job_category,
    budget = :budget,
    status = :status,
    updated_at = NOW()
WHERE updated_at = :updated_at;
-- job_application
-- 1. Update Job Application by ID
UPDATE job_applications
SET job_id = :job_id,
    worker_id = :worker_id,
    application_date = :application_date,
    status = :status,
    updated_at = NOW()
WHERE id = :id;

-- 2. Update Job Application by Job ID
UPDATE job_applications
SET id = :id,
    worker_id = :worker_id,
    application_date = :application_date,
    status = :status,
    updated_at = NOW()
WHERE job_id = :job_id;

-- 3. Update Job Application by Worker ID
UPDATE job_applications
SET id = :id,
    job_id = :job_id,
    application_date = :application_date,
    status = :status,
    updated_at = NOW()
WHERE worker_id = :worker_id;

-----------------------------------------
--job_contract
-- 1. Update Job Contract by ID
UPDATE job_contract
SET job_id = :job_id,
    worker_id = :worker_id,
    home_owner_id = :home_owner_id,
    contract_status = :contract_status,
    contract_start_date = :contract_start_date,
    contract_end_date = :contract_end_date,
    updated_at = NOW()
WHERE id = :id;

-- 2. Update Job Contract by Job ID
UPDATE job_contract
SET id = :id,
    worker_id = :worker_id,
    home_owner_id = :home_owner_id,
    contract_status = :contract_status,
    contract_start_date = :contract_start_date,
    contract_end_date = :contract_end_date,
    updated_at = NOW()
WHERE job_id = :job_id;

-- 3. Update Job Contract by Worker ID
UPDATE job_contract
SET id = :id,
    job_id = :job_id,
    home_owner_id = :home_owner_id,
    contract_status = :contract_status,
    contract_start_date = :contract_start_date,
    contract_end_date = :contract_end_date,
    updated_at = NOW()
WHERE worker_id = :worker_id;

-- 4. Update Job Contract by Home Owner ID
UPDATE job_contract
SET id = :id,
    job_id = :job_id,
    worker_id = :worker_id,
    contract_status = :contract_status,
    contract_start_date = :contract_start_date,
    contract_end_date = :contract_end_date,
    updated_at = NOW()
WHERE home_owner_id = :home_owner_id;

-- 5. Update Job Contract by Contract Status
UPDATE job_contract
SET id = :id,
    job_id = :job_id,
    worker_id = :worker_id,
    home_owner_id = :home_owner_id,
    contract_start_date = :contract_start_date,
    contract_end_date = :contract_end_date,
    updated_at = NOW()
WHERE contract_status = :contract_status;

-- 6. Update Job Contract by Contract Start Date
UPDATE job_contract
SET id = :id,
    job_id = :job_id,
    worker_id = :worker_id,
    home_owner_id = :home_owner_id,
    status = :status,
    contract_end_date = :contract_end_date,
    updated_at = NOW()
WHERE start_date = :contract_start_date;

-- 7. Update Job Contract by Contract End Date
-- 1. Update Job Contract by ID
UPDATE job_contract
SET job_id = :job_id,
    application_id = :application_id,
    user_worker_id = :user_worker_id,
    user_home_owner_id = :user_home_owner_id,
    acceptation_date = :acceptation_date,
    start_date = :start_date,
    end_date = :end_date,
    payment_id = :payment_id,
    terms = :terms,
    conditions = :conditions,
    updated_at = NOW()
WHERE id = :id;

-- 2. Update Job Contract by Job ID
UPDATE job_contract
SET id = :id,
    application_id = :application_id,
    user_worker_id = :user_worker_id,
    user_home_owner_id = :user_home_owner_id,
    acceptation_date = :acceptation_date,
    start_date = :start_date,
    end_date = :end_date,
    payment_id = :payment_id,
    terms = :terms,
    conditions = :conditions,
WHERE job_id = :job_id;
--home_owner
UPDATE home_owner
SET user_id = :user_id,
WHERE job_id = :job_id;
-- 2. Update Home Owner by User ID
UPDATE home_owner
SET job_id = :job_id,
WHERE user_id = :user_id;
-----------------------------------------
-- workers
UPDATE workers
-- 1. Update Worker by Application ID
UPDATE workers
SET user_id = :user_id,
    skills = :skills,
WHERE application_id = :application_id;

-- 2. Update Worker by User ID
UPDATE workers
SET application_id = :application_id,
    skills = :skills,
    updated_at = NOW()
WHERE user_id = :user_id;

---------------------------------
--payments
-- 1. Update Payment by ID
UPDATE payments
SET job_contract_id = :job_contract_id,
    payment_status = :payment_status,
    amount = :amount,
    payment_method = :payment_method,
    transaction_date = :transaction_date,
    updated_at = NOW()
WHERE id = :id;

-- 2. Update Payment by Job Contract ID
UPDATE payments
SET id = :id,
    payment_status = :payment_status,
    amount = :amount,
    payment_method = :payment_method,
    transaction_date = :transaction_date,
    updated_at = NOW()
WHERE job_contract_id = :job_contract_id;
--notifications
-- 1. Update Notification by ID
UPDATE notifications
SET user_id = :user_id,
    notification_text = :notification_text,
    notification_type = :notification_type,
    read_status = :read_status,
WHERE id = :id;

-- 2. Update Notification by User ID
UPDATE notifications
SET id = :id,
    notification_text = :notification_text,
    notification_type = :notification_type,
    read_status = :read_status,
WHERE user_id = :user_id;

--reviews_homeowner
--rating_homeowner

--reviews_worker
-- 1. Update Reviews Worker by ID
UPDATE reviews_worker
SET assigment_id = :assigment_id,
    reviewer_id = :reviewer_id,
    rating = :rating,
    review_text = :review_text,
WHERE id = :id;

-- 2. Update Reviews Worker by Assignment ID
UPDATE reviews_worker
SET id = :id,
    reviewer_id = :reviewer_id,
    rating = :rating,
    review_text = :review_text,
WHERE assigment_id = :assigment_id;
--rating_worker
-- 1. Update Rating Worker by ID
UPDATE rating_worker
SET assigment_id = :assigment_id,
    reviewer_id = :reviewer_id,
    rating = :rating,
WHERE id = :id;

-- 2. Update Rating Worker by Assignment ID
UPDATE rating_worker
SET id = :id,
    reviewer_id = :reviewer_id,
    rating = :rating,
WHERE assigment_id = :assigment_id;


```

### Deleting Data

```sql
-- user

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


--job

-- 1. Delete Job by ID
DELETE FROM jobs WHERE id = :id;

-- 2. Delete Job by Home Owner ID
DELETE FROM jobs WHERE home_owner_id = :home_owner_id;

-- 3. Delete Job by Description
DELETE FROM jobs WHERE description = :description;

-- 4. Delete Job by Location
DELETE FROM jobs WHERE location = :location;

-- 5. Delete Job by Job Type
DELETE FROM jobs WHERE job_type = :job_type;

-- 6. Delete Job by Job Category
DELETE FROM jobs WHERE job_category = :job_category;

-- 7. Delete Job by Budget
DELETE FROM jobs WHERE budget = :budget;

-- 8. Delete Job by Status
DELETE FROM jobs WHERE status = :status;

-- 9. Delete Job by Creation Date
DELETE FROM jobs WHERE created_at = :created_at;

-- 10. Delete Job by Update Date
DELETE FROM jobs WHERE updated_at = :updated_at;
-- job_application
-- 1. Delete Job Application by ID
DELETE FROM job_applications WHERE id = :id;

-- 2. Delete Job Application by Job ID
DELETE FROM job_applications WHERE job_id = :job_id;

-- 3. Delete Job Application by Worker ID
DELETE FROM job_applications WHERE worker_id = :worker_id;

--job_contract
-- 1. Delete Job Contract by ID
DELETE FROM job_contract WHERE id = :id;

-- 2. Delete Job Contract by Job ID
DELETE FROM job_contract WHERE job_id = :job_id;

--home_owner
-- 1. Delete Home Owner by Job ID
DELETE FROM home_owner WHERE job_id = :job_id;

-- 2. Delete Home Owner by User ID
DELETE FROM home_owner WHERE user_id = :user_id;

-- workers
-- 1. Delete Worker by Application ID
DELETE FROM workers WHERE application_id = :application_id;

-- 2. Delete Worker by User ID
DELETE FROM workers WHERE user_id = :user_id;

--payments
-- 1. Delete Payment by ID
DELETE FROM payments WHERE id = :id;

-- 2. Delete Payment by Job Contract ID
DELETE FROM payments WHERE job_contract_id = :job_contract_id;
--notifications
-- 1. Delete Notification by ID
DELETE FROM notifications WHERE id = :id;

-- 2. Delete Notification by User ID
DELETE FROM notifications WHERE user_id = :user_id;

--reviews_homeowner

--rating_homeowner
-- 1. Delete Rating Worker by ID
DELETE FROM rating_homeowner WHERE id = :id;

-- 2. Delete Rating Worker by Assignment ID
DELETE FROM rating_homeowner WHERE assigment_id = :assigment_id;

--reviews_worker
-- 1. Delete Review Worker by ID
DELETE FROM reviews_worker WHERE id = :id;

-- 2. Delete Review Worker by Assignment ID
DELETE FROM reviews_worker WHERE assigment_id = :assigment_id;

--rating_worker
-- 1. Delete Rating Worker by ID
DELETE FROM rating_worker WHERE id = :id;

-- 2. Delete Rating Worker by Assignment ID
DELETE FROM rating_worker WHERE assigment_id = :assigment_id;


```

#Complex Queries for Business Operations

""Find jobs with pending applications""

```sql
SELECT jobs.id, jobs.description, COUNT(job_applications.id) AS pending_applications
FROM jobs
LEFT JOIN job_applications ON jobs.id = job_applications.job_id AND job_applications.status = 'pending'
WHERE jobs.status = 'pending'
GROUP BY jobs.id;
```

--Retrieve earnings of a worker

```sql
SELECT SUM(payments.amount) AS total_earnings
FROM payments
INNER JOIN job_contract ON payments.job_contract_id = job_contract.id
WHERE job_contract.user_worker_id = ${worker_id};
```

#

Transaction Examples
Contract Creation and Payment

```sql
DO $$
DECLARE
    contract_id INT;
BEGIN
    -- Insert into job_contract and return the contract id
    INSERT INTO job_contract (job_id, application_id, user_worker_id, user_home_owner_id, acceptation_date)
    VALUES (${job_id}, ${application_id}, ${worker_id}, ${home_owner_id}, NOW())
    RETURNING id INTO contract_id;

    -- Insert into payments using the contract_id
    INSERT INTO payments (job_contract_id, amount, payment_status)
    VALUES (contract_id, ${amount}, 'pending');

    -- Commit the transaction (done implicitly in a DO block)
END $$;
```

#INDEXES

```sql
-- Add indexes for foreign key columns
CREATE INDEX idx_jobs_home_owner_id ON jobs(home_owner_id);
CREATE INDEX idx_job_applications_worker_id ON job_applications(worker_id);

-- Add indexes for filtering columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_jobs_status ON jobs(status);

```

-- if a column must be added to an existing TABLE , 'UPDATE A TABLE'

```sql
-- Update ENUM definition or use a VARCHAR/ENUM for roles
ALTER TABLE users ADD COLUMN role ENUM('home_owner', 'worker', 'admin') NOT NULL;

```

## 6. Troubleshooting

### Common Issues

1. Connection Failure

   - Symptoms: Unable to connect to the database.
   - Cause : Incorrect credentials or host configuration.
   - Solution: Verify the connection settings (hostname, port, username, password).

2. Data Integrity Issues
   - Symptoms :Foreign key violations when inserting or updating data.
   - Cause : Missing related entries in parent tables.
   - Solution :Ensure all related records (e.g., users, jobs) exist before inserting dependent records.

### Error Messages

ERROR: foreign key violation
Cause: A foreign key reference does not exist in the parent table.
Solution: Insert the parent record first, or check the foreign key constraints.

## 7. Maintenance

### Regular Tasks

- Daily checks :Backup and monitor database health.
- Weekly maintenance : Check for outdated records or unused data.
- Monthly reviews : Review performance metrics and optimize queries.
- Quarterly updates : Apply security patches and update dependencies.
- Annual audits : Review database schema and data consistency.

### Performance Optimization

- Index management : Regularly review and optimize indexes.
- Query optimization tips : Use EXPLAIN to analyze query performance , Optimize queries by avoiding SELECT \* and using LIMIT
- Resource monitoring:

## 8. Version History

| Version | Date       | Changes         | Author                                |
| ------- | ---------- | --------------- | ------------------------------------- |
| 1.0     | 2024-12-03 | Initial release | EDDALIA WISSAL \_ AMIEUR FATIMA ZAHRA |

## Contact Information

- Database Administrator: [name and contact]
- Support Team: [contact details]
- Emergency Contact: [urgent support contact]

## Appendix

### Glossary

CRUD : Create, Read, Update, Delete operations.
SQL : Structured Query Language
ENUM: A special data type that allows you to define a static set of values.
Composite Primary Key: A primary key made up of more than one column.
Foreign Key: A column that creates a link between two tables.
Index: A data structure that improves query performance by speeding up data retrieval.

### Additional Resources

- Related documentation :PostgreSQL Documentation: https://www.postgresql.org/docs/
- Training materials :SQL tutorials and courses: https://www.w3schools.com/sql/
- Useful links
