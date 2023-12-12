CREATE OR REPLACE PROCEDURE GetAllOrderItems(
    p_orderitems OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_orderitems FOR
    SELECT * FROM Order_Items;
END GetAllOrderItems;
