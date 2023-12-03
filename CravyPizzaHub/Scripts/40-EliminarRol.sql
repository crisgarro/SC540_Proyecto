CREATE OR REPLACE PROCEDURE DeleteRole (
    p_RoleID IN NUMBER,
    p_RowsAffected OUT NUMBER
)
IS
    v_UserCount NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_UserCount
    FROM User_Roles
    WHERE RoleID = p_RoleID;

    IF v_UserCount > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede elimianr el rol. Existen usuarios asignados al rol.');
    ELSE
        DELETE FROM Roles WHERE RoleID = p_RoleID;
        p_RowsAffected := SQL%ROWCOUNT;
        COMMIT;
    END IF;
END DeleteRole;
/