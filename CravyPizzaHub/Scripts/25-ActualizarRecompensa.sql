CREATE OR REPLACE PROCEDURE UpdateReward(
    p_RewardID IN Rewards.RewardID%TYPE,
    p_UserID IN Rewards.UserID%TYPE,
    p_Points IN Rewards.Points%TYPE
) AS
BEGIN
    UPDATE Rewards
    SET UserID = p_UserID,
        Points = p_Points
    WHERE RewardID = p_RewardID;
    COMMIT;
END UpdateReward;
/