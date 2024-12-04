--postgresql do not support ENUM type
CREATE TYPE job_type AS ENUM ('small_task', 'large_task');
CREATE TYPE job_status AS ENUM ('pending', 'in_progress', 'completed', 'cancelled');
CREATE TYPE job_category AS ENUM ('Babysitting', 'Child Care', 'Plumberie', 'Gardening');
CREATE TYPE application_status AS ENUM ('pending', 'accepted', 'rejected');
CREATE TYPE payment_status AS ENUM ('pending', 'completed', 'failed');
CREATE TYPE payment_method AS ENUM ('card', 'cash', 'wallet');
CREATE TYPE notification_type AS ENUM ('assigment_update', 'job_offer', 'message', 'application');
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
    job_category job_category NOT NULL,
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
    payment_method DEFAULT 'card',
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