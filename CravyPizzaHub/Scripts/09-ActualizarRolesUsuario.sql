CREATE OR REPLACE PROCEDURE UpdateUserRoles(
    p_UserRoleID IN NUMBER,
    p_UserID IN NUMBER,
    p_RoleID IN NUMBER,
    p_Success OUT NUMBER
)
AS
BEGIN
    UPDATE User_Roles
    SET UserID = p_UserID, RoleID = p_RoleID
    WHERE User_RoleID = p_UserRoleID;
    
    IF SQL%ROWCOUNT > 0 THEN
        p_Success := 1; -- Updated
    ELSE
        p_Success := 0; -- Not updated
    END IF;
    COMMIT;
END;