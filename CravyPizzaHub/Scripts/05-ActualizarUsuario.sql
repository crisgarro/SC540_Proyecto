CREATE OR REPLACE PROCEDURE UpdateUser(
    pUserID IN NUMBER,
    pUsername IN NVARCHAR2,
    pPassword IN NVARCHAR2,
    pEmail IN NVARCHAR2,
    pFirstName IN NVARCHAR2,
    pLastName IN NVARCHAR2,
    pAddress IN NVARCHAR2,
    pPhone IN NVARCHAR2,
    pIsUpdated OUT NUMBER
)
IS
BEGIN
    pIsUpdated := 0; 

    -- Verifica si el usuario existe 
    SELECT COUNT(*)
    INTO pIsUpdated
    FROM Users
    WHERE UserID = pUserID;

    IF pIsUpdated = 1 THEN
        -- Update the user's information
        UPDATE Users
        SET
            Username = pUsername,
            Password = pPassword,
            Email = pEmail,
            FirstName = pFirstName,
            LastName = pLastName,
            Address = pAddress,
            Phone = pPhone
        WHERE UserID = pUserID;
    END IF;
END;
/
