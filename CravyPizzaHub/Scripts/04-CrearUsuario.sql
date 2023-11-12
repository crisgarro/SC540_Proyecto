CREATE OR REPLACE PROCEDURE InsertUser (
    p_username IN NVARCHAR2,
    p_password IN NVARCHAR2,
    p_email IN NVARCHAR2,
    p_firstName IN NVARCHAR2,
    p_lastName IN NVARCHAR2,
    p_address IN NVARCHAR2,
    p_phone IN NVARCHAR2,
    p_lastLogin IN DATE, 
    p_requireChangePassword IN NUMBER,
    p_enable IN NUMBER, 
    p_disabledDate IN DATE, 
    p_userId OUT NUMBER
)
IS
BEGIN
    INSERT INTO Users (
        Username, Password, Email, FirstName, LastName, Address, Phone,
        Last_Login, Require_Change_Password, Enable, Disabled_Date
    ) VALUES (
        p_username, p_password, p_email, p_firstName, p_lastName, p_address, p_phone,
        p_lastLogin, p_requireChangePassword, p_enable, p_disabledDate
    ) RETURNING UserID INTO p_userId;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END InsertUser;
/
