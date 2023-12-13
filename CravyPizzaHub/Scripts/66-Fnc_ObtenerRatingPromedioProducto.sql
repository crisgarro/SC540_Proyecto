CREATE OR REPLACE FUNCTION GetAverageRatingForProduct(p_ProductID NUMBER) RETURN NUMBER IS
  v_AverageRating NUMBER;
BEGIN
  -- Calcular la puntuación promedio para un producto
  SELECT NVL(AVG(Rating), 0)
    INTO v_AverageRating
    FROM Product_Reviews
   WHERE ProductID = p_ProductID;

  RETURN v_AverageRating;
END GetAverageRatingForProduct;
/