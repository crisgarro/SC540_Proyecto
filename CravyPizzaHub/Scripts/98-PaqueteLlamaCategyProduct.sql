CREATE OR REPLACE PACKAGE CategProduc AS
    -- Procedimiento para insertar una categoría
    PROCEDURE InsertCategory(p_categoryname VARCHAR2);

    -- Procedimiento para insertar un producto
    PROCEDURE InsertProduct (
        p_name IN NVARCHAR2,
        p_description IN NVARCHAR2,
        p_price IN NUMBER,
        p_stockquantity IN NUMBER,
        p_productId OUT NUMBER,    
        p_categoryId IN NUMBER
    );
END CategProduc;
/

CREATE OR REPLACE PACKAGE BODY CategProduc AS
    -- Procedimiento para insertar una categoría
    PROCEDURE InsertCategory(p_categoryname VARCHAR2) AS
        v_count NUMBER;
    BEGIN
        -- Verificar si el nombre de la categoría ya existe
        SELECT COUNT(*)
        INTO v_count
        FROM categories
        WHERE UPPER(CATEGORYNAME) = UPPER(p_categoryname);

        -- Si la categoría ya existe, lanzar una excepción
        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20006, 'Ya existe una categoría con el mismo nombre.');
        END IF;

        -- Si no hay errores, realizar la inserción
        INSERT INTO categories (CATEGORYID, CATEGORYNAME, ENABLED, DISABLED_DATE)
        VALUES (CATEGORY_SEQUENCE.NEXTVAL, p_categoryname, 1, NULL);

        DBMS_OUTPUT.PUT_LINE('La categoría se agregó correctamente.');
    END InsertCategory;

    -- Procedimiento para insertar un producto
    PROCEDURE InsertProduct (
        p_name IN NVARCHAR2,
        p_description IN NVARCHAR2,
        p_price IN NUMBER,
        p_stockquantity IN NUMBER,
        p_productId OUT NUMBER,    
        p_categoryId IN NUMBER
    ) AS
    BEGIN    
        BEGIN
            INSERT INTO products (
                name, description, price, stockquantity, categoryId
            ) VALUES (
                p_name, p_description, p_price, p_stockquantity, p_categoryId
            ) RETURNING productId INTO p_productId;

            COMMIT;

            DBMS_OUTPUT.PUT_LINE('El producto se agregó correctamente.');
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                -- Manejar la excepción generada por el trigger
                IF SQLCODE = -20001 THEN
                    DBMS_OUTPUT.PUT_LINE('Error al insertar el producto: Ya existe un producto con el mismo nombre.');
                ELSE
                    RAISE;
                END IF;
        END;
    END InsertProduct;
END CategProduc;
/
