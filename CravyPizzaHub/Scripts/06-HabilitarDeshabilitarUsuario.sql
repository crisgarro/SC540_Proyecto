CREATE OR REPLACE PROCEDURE DisableUser(
    pUserID IN NUMBER,
    pEnable IN NUMBER, 
    pIsUpdated OUT NUMBER
)
IS
BEGIN
    pIsUpdated := 0;

    SELECT COUNT(*)
    INTO pIsUpdated
    FROM Users
    WHERE UserID = pUserID;

    IF pIsUpdated = 1 THEN
        UPDATE Users
        SET Enable = pEnable,
            Disabled_Date = CASE
                WHEN pEnable = 0 THEN SYSDATE  
                ELSE NULL 
            END
        WHERE UserID = pUserID;
    END IF;
END;
/