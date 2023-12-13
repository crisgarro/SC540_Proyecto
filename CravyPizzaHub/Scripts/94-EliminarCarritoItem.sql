CREATE OR REPLACE PROCEDURE DeleteCartItem(
    p_CartItemID IN NUMBER
)
IS
BEGIN
    DELETE FROM Cart_Items
    WHERE CartItemID = p_CartItemID;
END;
