CREATE OR REPLACE TRIGGER prevent_duplicate_user
BEFORE INSERT ON users
FOR EACH ROW
DECLARE
    existing_user_count NUMBER;
BEGIN
    -- Verificar si el usuario ya existe
    SELECT COUNT(*)
    INTO existing_user_count
    FROM users
    WHERE UPPER(USERNAME) = UPPER(:NEW.USERNAME);

    -- Si el usuario ya existe, lanzar una excepción
    IF existing_user_count > 0 THEN
        raise_application_error(-20001, 'Ya existe un usuario con el mismo nombre en la tabla.');
    END IF;
END;
/
