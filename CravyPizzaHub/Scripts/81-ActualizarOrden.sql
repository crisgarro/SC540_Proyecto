CREATE OR REPLACE PROCEDURE UpdateOrder(
    p_OrderID IN NUMBER,
    p_UserID IN NUMBER,
    p_TotalAmount IN NUMBER,
    p_PaymentMethodID IN NUMBER,
    p_ShippingMethodID IN NUMBER
)
IS
BEGIN
    UPDATE Orders
    SET UserID = p_UserID,
        TotalAmount = p_TotalAmount,
        PaymentMethodID = p_PaymentMethodID,
        ShippingMethodID = p_ShippingMethodID
    WHERE OrderID = p_OrderID;
END;
