CREATE OR REPLACE FUNCTION MostExpensiveShipping RETURN SYS_REFCURSOR IS
  cur SYS_REFCURSOR;
BEGIN
  OPEN cur FOR
    SELECT ShippingMethodName, MAX(ShippingCost) AS MaxShippingCost
    FROM Shipping_Methods;
  
  RETURN cur;
END MostExpensiveShipping;
/
