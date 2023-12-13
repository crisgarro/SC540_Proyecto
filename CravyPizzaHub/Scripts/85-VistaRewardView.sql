-- Crear la vista RewardsView
CREATE OR REPLACE VIEW RewardsView AS
SELECT RewardId, UserID, Points
FROM Rewards;
/