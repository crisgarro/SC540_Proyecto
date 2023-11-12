CREATE OR REPLACE PROCEDURE "DISABLEUSER" (
    pUserID IN NUMBER,
    pEnable IN NUMBER,
    pIsUpdated OUT NUMBER
)
IS
BEGIN
    pIsUpdated := 0;

    UPDATE Users
    SET Enable = pEnable,
        Disabled_Date = CASE
            WHEN pEnable = 0 THEN SYSDATE  
            ELSE NULL 
        END
    WHERE UserID = pUserID;

    pIsUpdated := SQL%ROWCOUNT; -- Get the number of rows affected by the update

    IF pIsUpdated = 1 THEN
        pIsUpdated := 1; -- Successfully updated
    END IF;
END;