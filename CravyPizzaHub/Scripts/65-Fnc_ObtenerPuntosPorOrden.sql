CREATE OR REPLACE FUNCTION GetRewardPointsForOrder(p_OrderID NUMBER) RETURN NUMBER IS
  v_TotalPoints NUMBER;
BEGIN
  -- Calcular el total de puntos de recompensa para un pedido
  SELECT NVL(SUM(p.Price * oi.Quantity), 0)
    INTO v_TotalPoints
    FROM Order_Items oi
         JOIN Products p ON oi.ProductID = p.ProductID
   WHERE oi.OrderID = p_OrderID;

  RETURN ROUND(v_TotalPoints);
END GetRewardPointsForOrder;
/
