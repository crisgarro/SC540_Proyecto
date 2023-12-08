CREATE OR REPLACE NONEDITIONABLE PROCEDURE UpdateNotifications(
    p_NOTIFICATIONID IN NUMBER,
    p_USERID IN NUMBER,
    p_Message IN NVARCHAR2,
    p_TIMESTAMP IN TIMESTAMP
) AS
BEGIN
    
    UPDATE Notifications
    SET
        Message = p_Message,
        Timestamp = p_TIMESTAMP
    WHERE
        NotificationID = p_NOTIFICATIONID
        AND UserID = p_USERID;



EXCEPTION
    WHEN OTHERS THEN
       
        RAISE;
END UpdateNotifications;
/
