CREATE OR REPLACE VIEW CartItemsView AS
SELECT c.cartid, p.name, ci.quantity, p.description
FROM Cart_Items ci
INNER JOIN Cart c on c.cartid = ci.cartid
INNER JOIN Products p on p.ProductID = ci.ProductID
INNER JOIN Users u on u.userId = c.userid
/