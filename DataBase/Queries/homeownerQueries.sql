INSERT INTO home_owner (job_id, user_id)
VALUES (:job_id, :user_id);
--select
-- Select Home Owner by Job ID
SELECT * FROM home_owner WHERE job_id = :job_id;
-- Select Home Owner by User ID
SELECT * FROM home_owner WHERE user_id = :user_id;
-- 1. Update Home Owner by Job ID
UPDATE home_owner
SET user_id = :user_id,
WHERE job_id = :job_id;

-- 2. Update Home Owner by User ID
UPDATE home_owner
SET job_id = :job_id,
WHERE user_id = :user_id;

--home_owner
-- 1. Delete Home Owner by Job ID
DELETE FROM home_owner WHERE job_id = :job_id;

-- 2. Delete Home Owner by User ID
DELETE FROM home_owner WHERE user_id = :user_id;