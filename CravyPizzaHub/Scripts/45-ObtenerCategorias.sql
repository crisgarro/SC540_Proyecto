CREATE OR REPLACE PROCEDURE RevokeRole (
   p_UserRoleID IN NUMBER,
   p_RowsAffected OUT NUMBER
) AS
BEGIN
   DELETE FROM User_Roles
   WHERE User_RoleID = p_UserRoleID;

   p_RowsAffected := SQL%ROWCOUNT;
END RevokeRole;
/