CREATE OR REPLACE PROCEDURE InsertReward(
    p_UserID IN NUMBER,
    p_Points IN NUMBER,
    p_RewardID OUT NUMBER
) AS
BEGIN
    INSERT INTO Rewards(UserID, Points)
    VALUES (p_UserID, p_Points)
    RETURNING RewardID INTO p_RewardID;

    COMMIT;
END InsertReward;
