CREATE OR REPLACE VIEW View_UsersWithRoles AS
SELECT U.UserID, U.Username, U.Email, U.FirstName, U.LastName, U.Address, U.Phone, U.Last_Login,
       UR.User_RoleID, R.RoleID, R.RoleName
FROM Users U
LEFT JOIN User_Roles UR ON U.UserID = UR.UserID
LEFT JOIN Roles R ON UR.RoleID = R.RoleID;