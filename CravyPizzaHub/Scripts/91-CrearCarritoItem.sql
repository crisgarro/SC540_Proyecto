CREATE OR REPLACE PROCEDURE InsertCartItem(
    p_CartID IN NUMBER,
    p_ProductID IN NUMBER,
    p_Quantity IN NUMBER,
    p_CartItemID OUT NUMBER
)
IS
BEGIN
    INSERT INTO Cart_Items (CartID, ProductID, Quantity)
    VALUES (p_CartID, p_ProductID, p_Quantity)
    RETURNING CartItemID INTO p_CartItemID;
END;
