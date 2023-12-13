CREATE OR REPLACE PROCEDURE UpdateCart(
    p_CartID IN NUMBER,
    p_UserID IN NUMBER
)
IS
BEGIN
    UPDATE Cart
    SET UserID = p_UserID
    WHERE CartID = p_CartID;
END;
