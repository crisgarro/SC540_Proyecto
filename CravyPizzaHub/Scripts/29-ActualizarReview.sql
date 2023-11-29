create or replace PROCEDURE UpdateReview(
    p_ReviewID IN NUMBER,
    p_Rating IN NUMBER,
    p_Comments IN NVARCHAR2
)
IS
BEGIN
    UPDATE Product_Reviews
    SET Rating = p_Rating, Comments = p_Comments
    WHERE ReviewID = p_ReviewID;
    COMMIT;
END UpdateReview;
/