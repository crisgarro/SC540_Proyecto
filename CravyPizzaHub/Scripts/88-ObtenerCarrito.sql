CREATE OR REPLACE PROCEDURE GetAllCarts(
    p_carts OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_carts FOR
    SELECT * FROM Cart;
END GetAllCarts;
