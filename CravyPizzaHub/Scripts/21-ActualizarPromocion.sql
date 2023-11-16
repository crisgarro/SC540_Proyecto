CREATE OR REPLACE PROCEDURE UpdatePromotion (
    p_PromotionID IN NUMBER,
    p_PromotionName IN NVARCHAR2,
    p_DiscountAmount IN NUMBER,
    p_StartDate IN DATE,
    p_EndDate IN DATE
)
IS
BEGIN
    UPDATE Promotions
    SET PromotionName = p_PromotionName,
        DiscountAmount = p_DiscountAmount,
        StartDate = p_StartDate,
        EndDate = p_EndDate
    WHERE PromotionID = p_PromotionID;
    COMMIT;
END UpdatePromotion;