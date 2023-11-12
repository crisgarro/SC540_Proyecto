CREATE OR REPLACE PROCEDURE GetUserRolesByUserName(
    p_UserRoles OUT SYS_REFCURSOR,
    p_UserName IN NVARCHAR2 -- New parameter for UserName
)
AS
BEGIN
    OPEN p_UserRoles FOR
    SELECT 
        UserID, Username, Email, FirstName, LastName, Address, Phone, Last_Login,
        User_RoleID, RoleID, RoleName
    FROM View_UsersWithRoles
    WHERE User_RoleID IS NOT NULL
    AND Username = p_UserName; -- Filter by UserName
END;