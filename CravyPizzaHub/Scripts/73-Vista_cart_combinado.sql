CREATE OR REPLACE VIEW cart_combinado AS
SELECT
    c.CARTID,
    c.USERID,
    ci.CARTITEMID,
    ci.PRODUCTID,
    ci.QUANTITY,
    u.USERNAME
FROM
    cart c
JOIN
    cart_items ci ON c.CARTID = ci.CARTID
JOIN
    users u ON c.USERID = u.USERID;
