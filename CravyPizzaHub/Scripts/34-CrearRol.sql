CREATE OR REPLACE PROCEDURE InsertRole (
    p_RoleName IN NVARCHAR2,
    p_RoleID OUT NUMBER
)
IS
BEGIN    
    INSERT INTO Roles (
        RoleName
    ) VALUES (
        p_RoleName
    ) RETURNING RoleID INTO p_RoleID;

    COMMIT;
END InsertRole;
/