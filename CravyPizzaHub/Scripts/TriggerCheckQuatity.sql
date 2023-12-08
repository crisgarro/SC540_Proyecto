-- Crear el trigger
CREATE OR REPLACE TRIGGER CheckQuantityTrigger
BEFORE INSERT OR UPDATE ON Cart_Items
FOR EACH ROW
BEGIN
    IF :NEW.Quantity < 10 THEN
        -- Puedes realizar acciones adicionales aqu�, como generar un mensaje de error o registrar la informaci�n.
        RAISE_APPLICATION_ERROR(-20001, 'La cantidad no puede ser inferior a 10.');
    END IF;
END;
/

