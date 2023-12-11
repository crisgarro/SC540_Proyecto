CREATE OR REPLACE TRIGGER validar_usuario_existente
BEFORE UPDATE ON users
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    -- Verificar si el usuario existe
    SELECT COUNT(*) INTO v_count
    FROM users
    WHERE USERID = :NEW.USERID;

    -- Si el usuario no existe, lanzar una excepción
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El usuario no existe.');
    END IF;
END;
/
