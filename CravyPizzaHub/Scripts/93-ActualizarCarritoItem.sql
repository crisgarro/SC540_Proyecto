CREATE OR REPLACE PROCEDURE UpdateCartItem(
    p_CartItemID IN NUMBER,
    p_CartID IN NUMBER,
    p_ProductID IN NUMBER,
    p_Quantity IN NUMBER
)
IS
BEGIN
    UPDATE Cart_Items
    SET CartID = p_CartID,
        ProductID = p_ProductID,
        Quantity = p_Quantity
    WHERE CartItemID = p_CartItemID;
END;
