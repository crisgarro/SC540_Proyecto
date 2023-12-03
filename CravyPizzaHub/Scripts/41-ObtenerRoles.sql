CREATE OR REPLACE PROCEDURE GetAllRoles(
    p_Result OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_Result FOR
    SELECT RoleID, RoleName FROM Roles;
END GetAllRoles;
/