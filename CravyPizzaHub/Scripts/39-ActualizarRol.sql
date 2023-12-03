CREATE OR REPLACE PROCEDURE UpdateRole(
    p_RoleID IN NUMBER,
    p_RoleName IN NVARCHAR2,
    p_WasUpdated OUT NUMBER
)
IS
BEGIN
    p_WasUpdated := 0;

    UPDATE Roles
    SET RoleName = p_RoleName
    WHERE RoleID = p_RoleID;

    IF SQL%ROWCOUNT > 0 THEN
        p_WasUpdated := 1;
    END IF;

    COMMIT;
END UpdateRole;
/