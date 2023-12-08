CREATE OR REPLACE FUNCTION AverageQuantityPerOrder RETURN NUMBER IS
  avgQuantity NUMBER;
BEGIN
  SELECT AVG(oi.Quantity) INTO avgQuantity
  FROM Order_Items oi;
  
  RETURN avgQuantity;
END AverageQuantityPerOrder;
/
