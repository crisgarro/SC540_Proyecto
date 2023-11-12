CREATE OR REPLACE PROCEDURE DeleteUserRoles(
    p_UserRoleID IN NUMBER,
    p_Success OUT NUMBER
)
AS
BEGIN
    DELETE FROM User_Roles
    WHERE User_RoleID = p_UserRoleID;
    
    IF SQL%ROWCOUNT > 0 THEN
        p_Success := 1; -- Deleted
    ELSE
        p_Success := 0; -- Not deleted
    END IF;
    COMMIT;
END;