CREATE OR REPLACE PROCEDURE UpdateProduct(
    pProductID IN NUMBER,
    pName IN NVARCHAR2,
    pDescription IN NVARCHAR2,
    pPrice IN NUMBER,
    pStockQuantity IN NUMBER,
    pCategoryId IN NUMBER,
    pIsUpdated OUT NUMBER
)
IS
BEGIN
    pIsUpdated := 0; 
    
    SELECT COUNT(*)
    INTO pIsUpdated
    FROM products
    WHERE productId = pproductId;

    IF pIsUpdated = 1 THEN        
        UPDATE products
        SET
            name = pName,
            description = pDescription,
            price = pPrice,
            stockquantity = pStockQuantity,
            categoryId = pCategoryId
        WHERE productId = pproductId;
    END IF;
END;
/