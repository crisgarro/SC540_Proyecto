CREATE OR REPLACE PROCEDURE GetNotificationByID(
    p_NOTIFICATIONID IN NUMBER,
    p_Notification OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_Notification FOR
        SELECT NotificationID, UserID, Message, Timestamp
        FROM Notifications
        WHERE NotificationID = p_NOTIFICATIONID;



EXCEPTION
    WHEN OTHERS THEN
     
        RAISE;
END GetNotificationByID;
/
