INSERT INTO jobs (home_owner_id, description, location, job_type, job_category, budget, status)
VALUES (:home_owner_id, :description, :location, :job_type, :job_category, :budget, :status)
RETURNING id;

--
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

--update
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
--delete
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
