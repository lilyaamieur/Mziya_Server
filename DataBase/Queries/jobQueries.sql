INSERT INTO jobs (
    home_owner_id, 
    description, 
    location, 
    job_type, 
    job_category, 
    budget, 
    status, 
    availability_type, 
    start_date, 
    end_date, 
    age_matters, 
    age_min, 
    age_max, 
    gender_matters, 
    required_gender, 
    additional_details
) 
VALUES (
    :home_owner_id,            -- home_owner_id (from the users table)
    :description,              -- job description
    :location,                 -- job location
    :job_type,                 -- job type (job_type enum)
    :job_category,             -- job category
    :budget,                   -- job budget
    :status,                   -- job status (default 'pending')
    :availability_type,       -- availability type ('open' or 'closed')
    :start_date,               -- start date (if availability_type = 'closed')
    :end_date,                 -- end date (if availability_type = 'closed')
    :age_matters,              -- whether age matters for the job
    :age_min,                  -- minimum age (if age_matters = true)
    :age_max,                  -- maximum age (if age_matters = true)
    :gender_matters,           -- whether gender matters for the job
    :required_gender,          -- required gender ('male', 'female', or 'any')
    :additional_details        -- additional details about worker requirements
)
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

-- 9. Select Job by Availability Type
SELECT * FROM jobs WHERE availability_type = :availability_type;

-- 10. Select Job by Start Date (For Closed Availability)
SELECT * FROM jobs WHERE start_date = :start_date;

-- 11. Select Job by End Date (For Closed Availability)
SELECT * FROM jobs WHERE end_date = :end_date;

-- 12. Select Job by Age Matters (whether age matters for workers)
SELECT * FROM jobs WHERE age_matters = :age_matters;

-- 13. Select Job by Minimum Age
SELECT * FROM jobs WHERE age_min = :age_min;

-- 14. Select Job by Maximum Age
SELECT * FROM jobs WHERE age_max = :age_max;

-- 15. Select Job by Gender Matters (whether gender matters for workers)
SELECT * FROM jobs WHERE gender_matters = :gender_matters;

-- 16. Select Job by Required Gender
SELECT * FROM jobs WHERE required_gender = :required_gender;

-- 17. Select Job by Additional Details
SELECT * FROM jobs WHERE additional_details = :additional_details;

-- 18. Select Job by Creation Date
SELECT * FROM jobs WHERE created_at = :created_at;

-- 19. Select Job by Update Date
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
    availability_type = :availability_type,
    start_date = :start_date,
    end_date = :end_date,
    age_matters = :age_matters,
    age_min = :age_min,
    age_max = :age_max,
    gender_matters = :gender_matters,
    required_gender = :required_gender,
    additional_details = :additional_details,
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
    availability_type = :availability_type,
    start_date = :start_date,
    end_date = :end_date,
    age_matters = :age_matters,
    age_min = :age_min,
    age_max = :age_max,
    gender_matters = :gender_matters,
    required_gender = :required_gender,
    additional_details = :additional_details,
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
    availability_type = :availability_type,
    start_date = :start_date,
    end_date = :end_date,
    age_matters = :age_matters,
    age_min = :age_min,
    age_max = :age_max,
    gender_matters = :gender_matters,
    required_gender = :required_gender,
    additional_details = :additional_details,
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
    availability_type = :availability_type,
    start_date = :start_date,
    end_date = :end_date,
    age_matters = :age_matters,
    age_min = :age_min,
    age_max = :age_max,
    gender_matters = :gender_matters,
    required_gender = :required_gender,
    additional_details = :additional_details,
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
    availability_type = :availability_type,
    start_date = :start_date,
    end_date = :end_date,
    age_matters = :age_matters,
    age_min = :age_min,
    age_max = :age_max,
    gender_matters = :gender_matters,
    required_gender = :required_gender,
    additional_details = :additional_details,
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
    availability_type = :availability_type,
    start_date = :start_date,
    end_date = :end_date,
    age_matters = :age_matters,
    age_min = :age_min,
    age_max = :age_max,
    gender_matters = :gender_matters,
    required_gender = :required_gender,
    additional_details = :additional_details,
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
   availability_type = :availability_type,
    start_date = :start_date,
    end_date = :end_date,
    age_matters = :age_matters,
    age_min = :age_min,
    age_max = :age_max,
    gender_matters = :gender_matters,
    required_gender = :required_gender,
    additional_details = :additional_details,
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
    availability_type = :availability_type,
    start_date = :start_date,
    end_date = :end_date,
    age_matters = :age_matters,
    age_min = :age_min,
    age_max = :age_max,
    gender_matters = :gender_matters,
    required_gender = :required_gender,
    additional_details = :additional_details,
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
    availability_type = :availability_type,
    start_date = :start_date,
    end_date = :end_date,
    age_matters = :age_matters,
    age_min = :age_min,
    age_max = :age_max,
    gender_matters = :gender_matters,
    required_gender = :required_gender,
    additional_details = :additional_details,
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
    availability_type = :availability_type,
    start_date = :start_date,
    end_date = :end_date,
    age_matters = :age_matters,
    age_min = :age_min,
    age_max = :age_max,
    gender_matters = :gender_matters,
    required_gender = :required_gender,
    additional_details = :additional_details,
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
-- 9. Delete Job by Availability Type
DELETE FROM jobs WHERE availability_type = :availability_type;

-- 10. Delete Job by Start Date (For Closed Availability)
DELETE FROM jobs WHERE start_date = :start_date;

-- 11. Delete Job by End Date (For Closed Availability)
DELETE FROM jobs WHERE end_date = :end_date;

-- 12. Delete Job by Age Matters (whether age matters for workers)
DELETE FROM jobs WHERE age_matters = :age_matters;

-- 13. Delete Job by Minimum Age
DELETE FROM jobs WHERE age_min = :age_min;

-- 14. Delete Job by Maximum Age
DELETE FROM jobs WHERE age_max = :age_max;

-- 15. Delete Job by Gender Matters (whether gender matters for workers)
DELETE FROM jobs WHERE gender_matters = :gender_matters;

-- 16. Delete Job by Required Gender
DELETE FROM jobs WHERE required_gender = :required_gender;

-- 17. Delete Job by Additional Details
DELETE FROM jobs WHERE additional_details = :additional_details;

-- 18. Delete Job by Creation Date
DELETE FROM jobs WHERE created_at = :created_at;

-- 19. Delete Job by Update Date
DELETE FROM jobs WHERE updated_at = :updated_at;