CREATE OR REPLACE FUNCTION BestSellingProducts RETURN SYS_REFCURSOR IS
  cur SYS_REFCURSOR;
BEGIN
  OPEN cur FOR
    SELECT oi.ProductID, COUNT(oi.OrderItemID) AS QuantitySold
    FROM Order_Items oi
    GROUP BY oi.ProductID
    ORDER BY QuantitySold DESC;
  
  RETURN cur;
END BestSellingProducts;
/
