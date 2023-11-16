CREATE OR REPLACE PROCEDURE GetAllReviews(
    p_Review OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_Result FOR
    SELECT * FROM Product_Reviews;
END GetAllReviews;
/
