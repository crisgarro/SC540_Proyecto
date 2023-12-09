CREATE VIEW ORDERID_ORDENITEMS AS
SELECT 
    oi.ORDERITEMID,
    oi.ORDERID AS order_item_order_id,
    oi.PRODUCTID,
    oi.QUANTITY,
    oi.SUBTOTAL,
    o.ORDERID AS order_order_id,
    o.USERID,
    o.ORDERDATE,
    o.TOTALAMOUNT,
    o.PAYMENTMETHODID,
    o.SHIPPINGMETHODID
FROM 
    ORDER_ITEMS oi
JOIN 
    ORDERS o ON oi.ORDERID = o.ORDERID;
