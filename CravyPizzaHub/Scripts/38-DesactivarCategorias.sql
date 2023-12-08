CREATE OR REPLACE PROCEDURE DisableCategories(
    pCategoryID IN NUMBER,
    pEnabled IN NUMBER,
    pIsUpdated OUT NUMBER
)
IS
BEGIN
    pIsUpdated := 0;

    SELECT COUNT(*)
    INTO pIsUpdated
    FROM Categories
    WHERE CategoryID = pCategoryID;

    IF pIsUpdated = 1 THEN
        UPDATE Categories
        SET Enabled = pEnabled
        WHERE CategoryID = pCategoryID;

        UPDATE Categories
        SET Disabled_Date = CASE
            WHEN pEnabled = 0 THEN SYSDATE
            ELSE NULL
        END
        WHERE CategoryID = pCategoryID;
    END IF;
END;
/
