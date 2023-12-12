CREATE OR REPLACE PROCEDURE GetAllOrders(
    p_ordenes OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_ordenes FOR
    SELECT * FROM Orders;
END GetAllOrders;
