CREATE OR REPLACE PROCEDURE DeleteReview(
    p_ReviewID IN NUMBER
)
IS
BEGIN
    DELETE FROM Product_Reviews WHERE ReviewID = p_ReviewID;
    COMMIT;
END DeleteReview;
