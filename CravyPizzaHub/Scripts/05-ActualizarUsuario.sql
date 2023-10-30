create or replace PROCEDURE UpdateUser(
    p_UserID IN NUMBER,
    p_Username IN NVARCHAR2,
    p_Password IN NVARCHAR2,
    p_Email IN NVARCHAR2,
    p_FirstName IN NVARCHAR2,
    p_LastName IN NVARCHAR2,
    p_Address IN NVARCHAR2,
    p_Phone IN NVARCHAR2,
    p_updatedUser OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_updatedUser FOR
    SELECT * FROM Users
    WHERE UserID = p_UserID;

    UPDATE Users
    SET
        Username = p_Username,
        Password = p_Password,
        Email = p_Email,
        FirstName = p_FirstName,
        LastName = p_LastName,
        Address = p_Address,
        Phone = p_Phone
    WHERE UserID = p_UserID;

    COMMIT;
END;