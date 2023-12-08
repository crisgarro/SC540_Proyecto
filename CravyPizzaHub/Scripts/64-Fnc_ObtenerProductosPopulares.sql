CREATE OR REPLACE FUNCTION HasAvailableReward(p_UserID NUMBER) RETURN BOOLEAN IS
  v_TotalRewards NUMBER;
BEGIN
  -- Verificar si el usuario tiene recompensas disponibles
  SELECT NVL(SUM(Points), 0)
    INTO v_TotalRewards
    FROM Rewards
   WHERE UserID = p_UserID;

  RETURN v_TotalRewards > 0;
END HasAvailableReward;
/
