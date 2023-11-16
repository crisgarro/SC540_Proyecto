CREATE OR REPLACE PROCEDURE UpdatePaymentMethod(
    p_PaymentMethodID IN NUMBER,
    p_NewPaymentMethodName IN NVARCHAR2,
    p_WasUpdated OUT NUMBER
)
IS
BEGIN
    p_WasUpdated := 0;
    
    UPDATE Payment_Methods
    SET PaymentMethodName = p_NewPaymentMethodName
    WHERE PaymentMethodID = p_PaymentMethodID;

    IF SQL%ROWCOUNT > 0 THEN
        p_WasUpdated := 1; 
    END IF;

    COMMIT;
END UpdatePaymentMethod;