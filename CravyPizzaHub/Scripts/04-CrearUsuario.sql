create or replace PROCEDURE "INSERTUSER" (
    p_username IN NVARCHAR2,
    p_password IN NVARCHAR2,
    p_email IN NVARCHAR2,
    p_firstName IN NVARCHAR2,
    p_lastName IN NVARCHAR2,
    p_address IN NVARCHAR2,
    p_phone IN NVARCHAR2,    
    p_userId OUT NUMBER
)
IS
BEGIN    
    INSERT INTO Users (
        Username, Password, Email, FirstName, LastName, Address, Phone, Enabled
    ) VALUES (
        p_username, p_password, p_email, p_firstName, p_lastName, p_address, p_phone, 1
    ) RETURNING UserID INTO p_userId;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END InsertUser;

