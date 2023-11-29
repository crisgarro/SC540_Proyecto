CREATE OR REPLACE PROCEDURE GetAllPaymentMethods(
    p_Result OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_Result FOR
    SELECT PaymentMethodID, PaymentMethodName, Enabled FROM Payment_Methods;
END GetAllPaymentMethods;
/