CREATE VIEW vista_combinada AS
SELECT 
    n.NOTIFICATIONID,
    n.USERID AS notification_user_id,
    ur.USER_ROLEID,
    ur.USERID AS role_user_id
FROM 
    notifications n
JOIN 
    User_Roles ur ON n.USERID = ur.USERID;

