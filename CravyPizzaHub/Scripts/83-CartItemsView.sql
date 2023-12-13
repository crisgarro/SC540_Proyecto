CREATE OR REPLACE VIEW CartItemsView AS
SELECT CartItemID, CartID, ProductID, Quantity
FROM Cart_Items;
/