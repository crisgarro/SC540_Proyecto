create or replace PROCEDURE DisablePaymentMethod (
    p_PaymentMethodID IN NUMBER,
    p_Enabled IN NUMBER,
    p_WasChanged OUT NUMBER
)
IS
BEGIN
    p_WasChanged := 0;

    UPDATE Payment_Methods
    SET enabled = p_Enabled
    WHERE PaymentMethodID = p_PaymentMethodID;

    IF SQL%ROWCOUNT > 0 THEN
        p_WasChanged := 1;
    END IF;

    COMMIT;
END DisablePaymentMethod;