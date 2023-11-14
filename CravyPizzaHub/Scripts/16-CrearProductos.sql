CREATE OR REPLACE PROCEDURE InsertProduct (
    p_name IN NVARCHAR2,
    p_description IN NVARCHAR2,
    p_price IN NUMBER,
    p_stockquantity IN NUMBER,
    p_productId OUT NUMBER,    
    p_categoryId IN NUMBER
)
IS
BEGIN    
    INSERT INTO products (
        name, description, price, stockquantity, categoryId
    ) VALUES (
        p_name, p_description, p_price, p_stockquantity, p_categoryId
    ) RETURNING productId INTO p_productId;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END InsertProduct;
/