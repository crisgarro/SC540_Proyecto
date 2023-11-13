CREATE OR REPLACE PROCEDURE DeleteProduct(
    p_ProductID IN NUMBER,
    p_Success OUT NUMBER
)
AS
BEGIN
    DELETE FROM products
    WHERE productId = p_productid;
    
    IF SQL%ROWCOUNT > 0 THEN
        p_Success := 1; -- Deleted
    ELSE
        p_Success := 0; -- Not deleted
    END IF;
    COMMIT;
END;