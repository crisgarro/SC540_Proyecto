create or replace PROCEDURE GetAllProducts (
    p_products OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_products FOR
    SELECT
        PRODUCTS.productid,
        PRODUCTS.NAME,
        PRODUCTS.description,
        PRODUCTS.price,
        PRODUCTS.stockquantity,
        PRODUCTS.categoryid
    FROM products;
END;
/