CREATE OR REPLACE PROCEDURE DeleteReward(
    p_RewardID IN Rewards.RewardID%TYPE
) AS
BEGIN
    DELETE FROM Rewards
    WHERE RewardID = p_RewardID;
    COMMIT;
END DeleteReward;
/