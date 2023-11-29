create or replace NONEDITIONABLE PROCEDURE DisableCategories (
 p_CATEGORYID IN NUMBER,
   p_CATEGORYNAME IN NVARCHAR2,
    p_WasChanged OUT NUMBER
)
IS
BEGIN
    p_WasChanged := 0;

    UPDATE categories
    SET enabled = p_Enabled
    WHERE CATEGORYID =p_CATEGORYID ;

    IF SQL%ROWCOUNT > 0 THEN
        p_WasChanged := 1;
    END IF;

    COMMIT;
END DisableCategories;