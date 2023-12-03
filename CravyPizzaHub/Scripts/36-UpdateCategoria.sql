CREATE OR REPLACE PROCEDURE UpdateCategory(
    p_CategoryID IN NUMBER,
    p_CategoryName IN NVARCHAR2,
    p_Enabled IN NUMBER
)
IS
    pIsUpdated NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO pIsUpdated
    FROM Categories
    WHERE CategoryID = p_CategoryID;

    IF pIsUpdated = 1 THEN
        UPDATE Categories
        SET
            CategoryName = p_CategoryName,
            Enabled = p_Enabled
        WHERE CategoryID = p_CategoryID;
    END IF;
END;
/
