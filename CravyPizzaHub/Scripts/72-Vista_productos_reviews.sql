CREATE OR REPLACE VIEW product_reviews_view AS
SELECT
    pr.REVIEWID,
    pr.USERID,
    pr.PRODUCTID,
    p.NAME AS PRODUCT_NAME,
    pr.RATING,
    pr.COMMENTS,
    pr.TIMESTAMP
FROM
    product_reviews pr
JOIN
    products p ON pr.PRODUCTID = p.PRODUCTID;
