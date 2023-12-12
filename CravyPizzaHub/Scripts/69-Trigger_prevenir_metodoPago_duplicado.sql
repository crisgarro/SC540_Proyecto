CREATE OR REPLACE TRIGGER prevent_duplicate_payment_method
BEFORE INSERT ON payment_methods
FOR EACH ROW
DECLARE
    existing_payment_method_count NUMBER;
BEGIN
    -- Verificar si el método de pago ya existe
    SELECT COUNT(*)
    INTO existing_payment_method_count
    FROM payment_methods
    WHERE UPPER(PAYMENTMETHODNAME) = UPPER(:NEW.PAYMENTMETHODNAME);

    -- Si el método de pago ya existe, lanzar una excepción
    IF existing_payment_method_count > 0 THEN
        raise_application_error(-20001, 'Ya existe un método de pago con el mismo nombre en la tabla.');
    END IF;
END;
/

