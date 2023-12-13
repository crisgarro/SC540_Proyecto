CREATE OR REPLACE PROCEDURE InsertOrderItem(
    p_OrderID IN NUMBER,
    p_ProductID IN NUMBER,
    p_Quantity IN NUMBER,
    p_Subtotal IN NUMBER,
    p_OrderItemID OUT NUMBER
)
IS
BEGIN
    INSERT INTO Order_Items (OrderID, ProductID, Quantity, Subtotal)
    VALUES (p_OrderID, p_ProductID, p_Quantity, p_Subtotal)
    RETURNING OrderItemID INTO p_OrderItemID;
END;
