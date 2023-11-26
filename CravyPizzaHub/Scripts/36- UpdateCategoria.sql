CREATE OR REPLACE NONEDITIONABLE PROCEDURE UpdateCategory(
   p_CATEGORYID IN NUMBER,
   p_CATEGORYNAME IN NVARCHAR2
)
IS
   pIsUpdated NUMBER := 0;  -- Declaración de la variable pIsUpdated
BEGIN
   SELECT COUNT(*)
   INTO pIsUpdated
   FROM categories
   WHERE CATEGORYID = p_CATEGORYID; -- Corrección en el nombre de la columna

   IF pIsUpdated = 1 THEN        
      UPDATE categories
      SET
         CATEGORYID  = p_CATEGORYID,
         CATEGORYNAME = p_CATEGORYNAME;
   END IF;
END;
