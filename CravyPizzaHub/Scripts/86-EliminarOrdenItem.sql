CREATE OR REPLACE PROCEDURE DeleteOrderItem(
    p_OrderItemID IN NUMBER
)
IS
BEGIN
    DELETE FROM Order_Items
    WHERE OrderItemID = p_OrderItemID;
END;
