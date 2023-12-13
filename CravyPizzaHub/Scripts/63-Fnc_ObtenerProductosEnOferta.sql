CREATE OR REPLACE FUNCTION GetAvailablePromotions RETURN SYS_REFCURSOR IS
  v_Cursor SYS_REFCURSOR;
BEGIN
  -- Obtener las promociones disponibles
  OPEN v_Cursor FOR
    SELECT *
      FROM Promotions
     WHERE StartDate <= SYSDATE AND EndDate >= SYSDATE;

  RETURN v_Cursor;
END GetAvailablePromotions;
/