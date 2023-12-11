CREATE OR REPLACE TRIGGER validar_categoria_existente
BEFORE INSERT ON categories
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    -- Verificar si el nombre de la categoría ya existe
    SELECT COUNT(*) INTO v_count
    FROM categories
    WHERE UPPER(CATEGORYNAME) = UPPER(:NEW.CATEGORYNAME);

    -- Si la categoría ya existe, lanzar una excepción
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Ya existe una categoría con el mismo nombre.');
    END IF;
END;
/
