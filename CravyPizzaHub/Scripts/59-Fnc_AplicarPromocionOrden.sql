CREATE OR REPLACE FUNCTION ApplyPromotionToOrder(p_OrderID NUMBER, p_PromotionID NUMBER) RETURN NUMBER IS
  v_AppliedPromotionID NUMBER;
BEGIN
  -- Aplicar la promoción al pedido
  INSERT INTO Applied_Promotions (OrderID, PromotionID)
  VALUES (p_OrderID, p_PromotionID)
  RETURNING AppliedPromotionID INTO v_AppliedPromotionID;

  RETURN v_AppliedPromotionID;
END ApplyPromotionToOrder;
/
