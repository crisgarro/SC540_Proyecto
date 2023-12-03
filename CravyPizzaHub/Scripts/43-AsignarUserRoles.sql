CREATE OR REPLACE PROCEDURE AssignRole (
   p_UserID IN NUMBER,
   p_RoleID IN NUMBER,
   p_UserRoleID OUT NUMBER
) AS
BEGIN
   INSERT INTO User_Roles (UserID, RoleID)
   VALUES (p_UserID, p_RoleID)
   RETURNING User_RoleID INTO p_UserRoleID;
END AssignRole;
/