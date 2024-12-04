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
-- job_application
-- 1. Delete Job Application by ID
DELETE FROM job_applications WHERE id = :id;

-- 2. Delete Job Application by Job ID
DELETE FROM job_applications WHERE job_id = :job_id;

-- 3. Delete Job Application by Worker ID
DELETE FROM job_applications WHERE worker_id = :worker_id;
