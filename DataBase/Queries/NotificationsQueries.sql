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

--notifications
INSERT INTO notifications (user_id, notification_text, notification_type, read_status)
VALUES (:user_id, :notification_text, :notification_type, :read_status)
RETURNING id;
--notifications
-- 1. Delete Notification by ID
DELETE FROM notifications WHERE id = :id;

-- 2. Delete Notification by User ID
DELETE FROM notifications WHERE user_id = :user_id;