CREATE OR REPLACE PROCEDURE GetAllCartItems(
    p_cartitems OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cartitems FOR
    SELECT * FROM Cart_Items;
END GetAllCartItems;
