create or replace NONEDITIONABLE PROCEDURE InsertCategories (
  p_CATEGORYID IN NUMBER,
    p_CATEGORYNAME IN NVARCHAR2
)
IS
BEGIN
    INSERT INTO categories (categoryid, categoryname)
    VALUES (p_CATEGORYID, p_CATEGORYNAME);
    COMMIT;
END InsertCategories;