create or replace TRIGGER prevent_duplicate_product
BEFORE INSERT ON products
FOR EACH ROW
DECLARE
    existing_product_count NUMBER;
BEGIN
    -- Verificar si ya existe un producto con el mismo nombre
    SELECT COUNT(*)
    INTO existing_product_count
    FROM products
    WHERE UPPER(name) = UPPER(:NEW.name);

    -- Si ya existe un producto con el mismo nombre, lanzar una excepción
    IF existing_product_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Ya existe un producto con el mismo nombre en la tabla.');
    END IF;
END;
/