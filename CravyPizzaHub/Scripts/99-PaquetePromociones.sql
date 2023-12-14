CREATE OR REPLACE PACKAGE PromocionesDisponibles AS
  -- Declaración del procedimiento
  PROCEDURE GetAllPromotions(p_Cursor OUT SYS_REFCURSOR, p_TotalPromotions OUT NUMBER);

  -- Declaración de la función
  FUNCTION GetAvailablePromotions RETURN SYS_REFCURSOR;
END PromocionesDisponibles;
/

CREATE OR REPLACE PACKAGE BODY PromocionesDisponibles AS
  -- Implementación del procedimiento
  PROCEDURE GetAllPromotions(p_Cursor OUT SYS_REFCURSOR, p_TotalPromotions OUT NUMBER) IS
  BEGIN
    OPEN p_Cursor FOR
      SELECT PromotionID, PromotionName, DiscountAmount, StartDate, EndDate
      FROM Promotions;

    -- Obtener el total de promociones
    SELECT COUNT(*) INTO p_TotalPromotions FROM Promotions;
  END GetAllPromotions;

  -- Implementación de la función
  FUNCTION GetAvailablePromotions RETURN SYS_REFCURSOR IS
    v_Cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_Cursor FOR
      SELECT *
      FROM Promotions
      WHERE StartDate <= SYSDATE AND EndDate >= SYSDATE;

    RETURN v_Cursor;
  END GetAvailablePromotions;
END PromocionesDisponibles;
/
