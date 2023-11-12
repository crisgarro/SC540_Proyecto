CREATE OR REPLACE PROCEDURE GetAllUserRoles(
    p_UserRoles OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_UserRoles FOR
    SELECT 
        UserID, Username, Email, FirstName, LastName, Address, Phone, Last_Login,
        User_RoleID, RoleID, RoleName
    FROM View_UsersWithRoles;
END;