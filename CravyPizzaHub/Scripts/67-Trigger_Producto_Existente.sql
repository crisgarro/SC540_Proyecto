CREATE OR REPLACE TRIGGER validar_producto_existente
BEFORE INSERT ON products
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    -- Verificar si ya existe un producto con el mismo nombre
    SELECT COUNT(*) INTO v_count
    FROM products
    WHERE UPPER(name) = UPPER(:NEW.name);

    -- Si el producto ya existe, lanzar una excepción
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Ya existe un producto con el mismo nombre.');
    END IF;
END;
/
