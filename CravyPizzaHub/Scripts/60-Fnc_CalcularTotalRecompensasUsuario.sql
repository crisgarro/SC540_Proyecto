CREATE OR REPLACE FUNCTION CalculateTotalRewards(p_UserID NUMBER) RETURN NUMBER IS
  v_TotalRewards NUMBER;
BEGIN
  -- Calcular el total de recompensas del usuario
  SELECT NVL(SUM(Points), 0)
    INTO v_TotalRewards
    FROM Rewards
   WHERE UserID = p_UserID;

  RETURN v_TotalRewards;
END CalculateTotalRewards;
/
