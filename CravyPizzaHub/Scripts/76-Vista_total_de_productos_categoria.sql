CREATE OR REPLACE VIEW total_products_by_category_view AS
SELECT
    CATEGORYID,
    COUNT(*) AS total_products
FROM
    products
GROUP BY
    CATEGORYID;
