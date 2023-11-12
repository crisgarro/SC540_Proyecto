CREATE OR REPLACE PROCEDURE "DISABLEUSER" (
    pUserID IN NUMBER,
    pEnabled IN NUMBER,
    pIsUpdated OUT NUMBER
)
IS
BEGIN
    pIsUpdated := 0;

    UPDATE Users
    SET Enabled = pEnabled,
        Disabled_Date = CASE
            WHEN pEnabled = 0 THEN SYSDATE  
            ELSE NULL 
        END
    WHERE UserID = pUserID;

    pIsUpdated := SQL%ROWCOUNT; 

    IF pIsUpdated = 1 THEN
        pIsUpdated := 1; 
    END IF;
END;