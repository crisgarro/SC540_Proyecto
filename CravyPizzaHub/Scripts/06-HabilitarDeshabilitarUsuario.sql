create or replace PROCEDURE            "DISABLEUSER" (
    pUserID IN NUMBER,
    pEnabled IN NUMBER, -- Updating the parameter to match the field type in the table
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
        SET Enabled = pEnabled,
            Disabled_Date = CASE
                WHEN pEnabled = 0 THEN SYSDATE  
                ELSE NULL 
            END
        WHERE UserID = pUserID;
    END IF;
END;

