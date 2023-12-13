CREATE OR REPLACE PROCEDURE AssignRole (
   p_UserID IN NUMBER,
   p_RoleID IN NUMBER,
   p_UserRoleID OUT NUMBER
) AS
   duplicate_key EXCEPTION;
   PRAGMA EXCEPTION_INIT(duplicate_key, -1); -- Adjust the error code based on your database

BEGIN
   BEGIN
      INSERT INTO User_Roles (UserID, RoleID)
      VALUES (p_UserID, p_RoleID)
      RETURNING User_RoleID INTO p_UserRoleID;
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         RAISE duplicate_key;
   END;
END AssignRole;
/