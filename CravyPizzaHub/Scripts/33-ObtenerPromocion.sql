CREATE OR REPLACE PROCEDURE GetAllPromotions (
    p_Cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_Cursor FOR
    SELECT PromotionID, PromotionName, DiscountAmount, StartDate, EndDate
    FROM Promotions;
END GetAllPromotions;
/