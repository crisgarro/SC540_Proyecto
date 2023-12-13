CREATE OR REPLACE PROCEDURE UpdateOrderItem(
    p_OrderItemID IN NUMBER,
    p_OrderID IN NUMBER,
    p_ProductID IN NUMBER,
    p_Quantity IN NUMBER,
    p_Subtotal IN NUMBER
)
IS
BEGIN
    UPDATE Order_Items
    SET OrderID = p_OrderID,
        ProductID = p_ProductID,
        Quantity = p_Quantity,
        Subtotal = p_Subtotal
    WHERE OrderItemID = p_OrderItemID;
END;
