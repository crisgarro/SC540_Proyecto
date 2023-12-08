CREATE OR REPLACE FUNCTION TotalSalesByUser(userID IN NUMBER) RETURN NUMBER IS
  totalSales NUMBER(10, 2);
BEGIN
  SELECT SUM(o.TotalAmount) INTO totalSales
  FROM Orders o
  WHERE o.UserID = userID;
  
  RETURN totalSales;
END TotalSalesByUser;
/
