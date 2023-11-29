CREATE OR REPLACE PROCEDURE InsertPromotion (
    p_PromotionName IN NVARCHAR2,
    p_DiscountAmount IN NUMBER,
    p_StartDate IN DATE,
    p_EndDate IN DATE
)
IS
BEGIN
    INSERT INTO Promotions (PromotionName, DiscountAmount, StartDate, EndDate)
    VALUES (p_PromotionName, p_DiscountAmount, p_StartDate, p_EndDate);
    COMMIT;
END InsertPromotion;
/