create or replace PROCEDURE GetAllReviews(
    p_Review OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_Review FOR
    SELECT * FROM Product_Reviews;
END GetAllReviews;
/