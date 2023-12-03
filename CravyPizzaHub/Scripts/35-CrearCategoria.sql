CREATE OR REPLACE PROCEDURE InsertCategory (
    p_CategoryName IN NVARCHAR2,
    p_Enabled IN NUMBER,
    p_CategoryID OUT NUMBER
)
IS
BEGIN    
    INSERT INTO Categories (
        CategoryName, Enabled
    ) VALUES (
        p_CategoryName, p_Enabled
    ) RETURNING CategoryID INTO p_CategoryID;

    COMMIT;
END InsertCategory;
/