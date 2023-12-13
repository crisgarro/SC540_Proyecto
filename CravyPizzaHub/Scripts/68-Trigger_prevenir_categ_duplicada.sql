CREATE OR REPLACE TRIGGER prevent_duplicate_category
BEFORE INSERT ON categories
FOR EACH ROW
DECLARE
    existing_category_count NUMBER;
BEGIN
    -- Verificar si la categoría ya existe
    SELECT COUNT(*)
    INTO existing_category_count
    FROM categories
    WHERE UPPER(CATEGORYNAME) = UPPER(:NEW.CATEGORYNAME);

    -- Si la categoría ya existe, realizar un rollback y no insertar la nueva categoría
    IF existing_category_count > 0 THEN
        :NEW.CATEGORYID := NULL; -- Anular el intento de inserción asignando NULL a CATEGORYID
        :NEW.CATEGORYNAME := NULL; -- Anular el intento de inserción asignando NULL a CATEGORYNAME
        :NEW.ENABLED := NULL; -- Anular el intento de inserción asignando NULL a ENABLED
        :NEW.DISABLED_DATE := NULL; -- Anular el intento de inserción asignando NULL a DISABLED_DATE
    ELSE
        -- Si la categoría no existe, permitir la inserción
        NULL; -- No es necesario hacer nada
    END IF;
END;
/