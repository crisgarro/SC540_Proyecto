CREATE OR REPLACE FUNCTION PlaceOrder(p_UserID NUMBER, p_PaymentMethodID NUMBER, p_ShippingMethodID NUMBER) RETURN NUMBER IS
  v_OrderID NUMBER;
  v_TotalAmount NUMBER(10, 2);
BEGIN
  -- Calcular el total del carrito
  SELECT NVL(SUM(p.Price * ci.Quantity), 0)
    INTO v_TotalAmount
    FROM Cart_Items ci
         JOIN Products p ON ci.ProductID = p.ProductID
   WHERE ci.CartID = (SELECT CartID FROM Cart WHERE UserID = p_UserID);

  -- Crear el pedido
  INSERT INTO Orders (UserID, TotalAmount, PaymentMethodID, ShippingMethodID)
  VALUES (p_UserID, v_TotalAmount, p_PaymentMethodID, p_ShippingMethodID)
  RETURNING OrderID INTO v_OrderID;

  -- Mover elementos del carrito al pedido
  INSERT INTO Order_Items (OrderID, ProductID, Quantity, Subtotal)
  SELECT v_OrderID, ci.ProductID, ci.Quantity, p.Price * ci.Quantity
    FROM Cart_Items ci
         JOIN Products p ON ci.ProductID = p.ProductID
   WHERE ci.CartID = (SELECT CartID FROM Cart WHERE UserID = p_UserID);

  -- Limpiar el carrito
  DELETE FROM Cart_Items WHERE CartID = (SELECT CartID FROM Cart WHERE UserID = p_UserID);

  RETURN v_OrderID;
END PlaceOrder;
/
