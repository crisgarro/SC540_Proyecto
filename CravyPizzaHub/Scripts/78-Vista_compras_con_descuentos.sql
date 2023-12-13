CREATE OR REPLACE VIEW compras_con_descuentos AS
SELECT
    o.ORDERID,
    o.TOTALAMOUNT,
    p.PROMOTIONNAME,
    p.STARTDATE,
    p.ENDDATE,
    p.DISCOUNTAMOUNT,
    u.FIRSTNAME,
    u.LASTNAME
FROM
    orders o
JOIN
    applied_promotions ap ON o.ORDERID = ap.ORDERID
JOIN
    promotions p ON ap.PROMOTIONID = p.PROMOTIONID
JOIN
    users u ON o.USERID = u.USERID;
/