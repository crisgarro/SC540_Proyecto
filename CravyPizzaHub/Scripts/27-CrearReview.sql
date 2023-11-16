CREATE OR REPLACE PROCEDURE InsertReview(
    p_UserID IN NUMBER,
    p_ProductID IN NUMBER,
    p_Rating IN NUMBER,
    p_Comments IN NVARCHAR2,
    p_Timestamp IN TIMESTAMP,
    p_ReviewID OUT NUMBER
)
IS
BEGIN
    INSERT INTO Product_Reviews(UserID, ProductID, Rating, Comments, Timestamp)
    VALUES (p_UserID, p_ProductID, p_Rating, p_Comments, p_Timestamp)
    RETURNING ReviewID INTO p_ReviewID; 
    
    COMMIT;
END InsertReview;
/