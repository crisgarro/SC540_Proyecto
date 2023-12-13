CREATE OR REPLACE PROCEDURE InsertOrder(
    p_UserID IN NUMBER,
    p_TotalAmount IN NUMBER,
    p_PaymentMethodID IN NUMBER,
    p_ShippingMethodID IN NUMBER,
    p_OrderID OUT NUMBER
)
IS
BEGIN
    INSERT INTO Orders (UserID, TotalAmount, PaymentMethodID, ShippingMethodID)
    VALUES (p_UserID, p_TotalAmount, p_PaymentMethodID, p_ShippingMethodID)
    RETURNING OrderID INTO p_OrderID;
END;
/