CREATE OR REPLACE TRIGGER validar_rol_existente
BEFORE INSERT ON roles
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    -- Verificar si el rol ya existe
    SELECT COUNT(*) INTO v_count
    FROM roles
    WHERE UPPER(ROLENAME) = UPPER(:NEW.ROLENAME);

    -- Si el rol ya existe, lanzar una excepción
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'El rol ya existe.');
    END IF;
END;
/
