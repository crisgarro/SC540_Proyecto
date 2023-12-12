CREATE OR REPLACE VIEW total_products_view AS
SELECT
    COUNT(*) AS total_products
FROM
    products;