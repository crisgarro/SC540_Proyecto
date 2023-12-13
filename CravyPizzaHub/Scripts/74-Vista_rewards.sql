CREATE OR REPLACE VIEW user_rewards_view AS
SELECT
    u.USERNAME,
    u.FIRSTNAME,
    u.LASTNAME,
    u.PHONE,
    r.REWARDID,
    r.USERID,
    r.POINTS AS "TOTAL OF POINTS"
FROM
    users u
JOIN
    rewards r ON u.USERID = r.USERID;
/