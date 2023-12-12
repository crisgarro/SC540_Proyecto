CREATE OR REPLACE VIEW orders_total_amount_view AS
SELECT
    ORDERID,
    USERID,
    ORDERDATE,
    TOTALAMOUNT,
    PAYMENTMETHODID,
    SHIPPINGMETHODID
FROM
    orders
WHERE
    TRUNC(ORDERDATE) = TRUNC(SYSDATE); -- Filtrar por la fecha actual (puedes ajustar esta condición según tus necesidades)
