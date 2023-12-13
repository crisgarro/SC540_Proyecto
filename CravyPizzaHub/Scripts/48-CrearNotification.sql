create or replace PROCEDURE InsertNotifications (  
    p_USERID IN NUMBER,
        p_MESSAGE  IN NVARCHAR2,
        p_TIMESTAMP IN TIMESTAMP
)
IS
BEGIN
    INSERT INTO notifications (USERID,MESSAGE,TIMESTAMP )
    VALUES ( p_USERID, p_MESSAGE, p_TIMESTAMP);
    COMMIT;
END InsertNotifications;
/