CREATE OR REPLACE FUNCTION AddToCart(p_UserID NUMBER, p_ProductID NUMBER, p_Quantity NUMBER) RETURN NUMBER IS
  v_CartID NUMBER;
BEGIN
  -- Obtener el carrito del usuario o crear uno nuevo
  SELECT CartID INTO v_CartID FROM Cart WHERE UserID = p_UserID;
  IF v_CartID IS NULL THEN
    INSERT INTO Cart (UserID) VALUES (p_UserID) RETURNING CartID INTO v_CartID;
  END IF;

  -- Agregar el producto al carrito
  INSERT INTO Cart_Items (CartID, ProductID, Quantity)
  VALUES (v_CartID, p_ProductID, p_Quantity);

  RETURN v_CartID;
END AddToCart;
/
