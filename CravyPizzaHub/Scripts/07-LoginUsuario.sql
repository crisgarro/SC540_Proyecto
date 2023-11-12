CREATE OR REPLACE PROCEDURE UserLogin(
    pUsername IN NVARCHAR2,
    pPassword IN NVARCHAR2,
    pUser OUT SYS_REFCURSOR
)
IS
    vUserID NUMBER;
BEGIN
    OPEN pUser FOR
    SELECT *
    FROM Users
    WHERE Username = pUsername
    AND Password = pPassword;

    SELECT UserID
    INTO vUserID
    FROM Users
    WHERE Username = pUsername
    AND Password = pPassword;

    IF vUserID IS NOT NULL THEN
        UPDATE Users
        SET Last_Login = SYSDATE
        WHERE UserID = vUserID;
    END IF;
END;
/
