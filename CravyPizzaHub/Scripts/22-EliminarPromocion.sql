CREATE OR REPLACE PROCEDURE DeletePromotion (
    p_PromotionID IN NUMBER
)
IS
BEGIN
    DELETE FROM Promotions
    WHERE PromotionID = p_PromotionID;
    COMMIT;
END DeletePromotion;
/