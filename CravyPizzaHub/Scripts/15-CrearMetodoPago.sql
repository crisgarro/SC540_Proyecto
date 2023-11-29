CREATE OR REPLACE PROCEDURE InsertPaymentMethod (
    p_PaymentMethodName IN NVARCHAR2,
    p_Enabled IN NUMBER,
    p_PaymentMethodID OUT NUMBER
)
IS
BEGIN    
    INSERT INTO Payment_Methods (
        PaymentMethodName, Enabled
    ) VALUES (
        p_PaymentMethodName, p_Enabled
    ) RETURNING PaymentMethodID INTO p_PaymentMethodID;

    COMMIT;
END InsertPaymentMethod;
/