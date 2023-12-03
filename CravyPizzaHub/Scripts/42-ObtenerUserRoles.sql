CREATE OR REPLACE PROCEDURE GetAllUserRoles (
   p_Result OUT SYS_REFCURSOR
) AS
BEGIN
   OPEN p_Result FOR
      SELECT UR.User_RoleId, UR.userId, UR.RoleId , U.UserName, R.RoleName
      FROM Users U
      JOIN User_Roles UR ON U.UserID = UR.UserID
      JOIN Roles R ON UR.RoleId = R.RoleID;
END GetAllUserRoles;
/