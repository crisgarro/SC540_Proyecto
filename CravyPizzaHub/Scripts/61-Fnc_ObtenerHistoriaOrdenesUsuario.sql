CREATE OR REPLACE FUNCTION GetOrderHistory(p_UserID NUMBER) RETURN SYS_REFCURSOR IS
  v_Cursor SYS_REFCURSOR;
BEGIN
  -- Obtener el historial de pedidos del usuario
  OPEN v_Cursor FOR
    SELECT *
      FROM Orders
     WHERE UserID = p_UserID
  ORDER BY OrderDate DESC;

  RETURN v_Cursor;
END GetOrderHistory;
/
