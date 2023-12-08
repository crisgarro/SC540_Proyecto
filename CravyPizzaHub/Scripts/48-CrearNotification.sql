create or replace NONEDITIONABLE PROCEDURE InsertNotifications (
  p_NOTIFICATIONID IN NUMBER,
    p_USERID IN NUMBER,
        p_MESSAGE  IN NVARCHAR2,
        p_TIMESTAMP IN TIMESTAMP
)
IS
BEGIN
    INSERT INTO NOTIFICATONS (NOTIFICATIONID,USERID,MESSAGE,TIMESTAMP )
    VALUES ( p_NOTIFICATIONID, p_USERID, p_MESSAGE,   p.TIMESTAMP);
    COMMIT;
END InsertNotifications;