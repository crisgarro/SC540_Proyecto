CREATE OR REPLACE PROCEDURE GetAllRewards(
    p_RewardInfo OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_RewardInfo FOR
    SELECT *
    FROM Rewards;
END GetAllRewards;
/
