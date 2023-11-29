CREATE OR REPLACE NONEDITIONABLE PROCEDURE DeleteCategory(
   p_CATEGORYID IN NUMBER,
   p_CATEGORYNAME IN NVARCHAR2
)
AS
   p_Success NUMBER := 0;  -- Declaración de la variable p_Success
BEGIN
   DELETE FROM categories
   WHERE CATEGORYID = p_CATEGORYID;

   IF SQL%ROWCOUNT > 0 THEN
      p_Success := 1; -- Eliminado
   ELSE
      p_Success := 0; -- No eliminado
   END IF;

   COMMIT;
END;
/