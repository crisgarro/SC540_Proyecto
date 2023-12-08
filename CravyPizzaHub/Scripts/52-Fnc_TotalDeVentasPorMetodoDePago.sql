CREATE OR REPLACE FUNCTION TotalSalesByShipping RETURN NUMBER IS
  totalSales NUMBER(10, 2);
BEGIN
  SELECT SUM(o.TotalAmount) INTO totalSales
  FROM Orders o
  JOIN Shipping_Methods sm ON o.ShippingMethodID = sm.ShippingMethodID;
  
  RETURN totalSales;
END TotalSalesByShipping;
/