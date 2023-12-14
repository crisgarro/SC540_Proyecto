INSERT INTO Users (Username, Password, Email, FirstName, LastName, Address, Phone, Last_Login)
VALUES ('user1', 'password1', 'user1@email.com', 'John', 'Doe', '123 Main St', '1234567890', SYSTIMESTAMP);

INSERT INTO Users (Username, Password, Email, FirstName, LastName, Address, Phone, Last_Login)
VALUES ('user2', 'password2', 'user2@email.com', 'Jane', 'Smith', '456 Oak St', '9876543210', SYSTIMESTAMP);

INSERT INTO Roles (RoleName) VALUES ('Admin');
INSERT INTO Roles (RoleName) VALUES ('Customer');

INSERT INTO User_Roles (UserID, RoleID) VALUES (1, 1);
INSERT INTO User_Roles (UserID, RoleID) VALUES (2, 2);

INSERT INTO Categories (CategoryName) VALUES ('Vegetarian');
INSERT INTO Categories (CategoryName) VALUES ('Meat Lovers');
INSERT INTO Categories (CategoryName) VALUES ('Vegan Delight');
INSERT INTO Categories (CategoryName) VALUES ('Seafood Sensation');
INSERT INTO Categories (CategoryName) VALUES ('Gluten-Free Options');
INSERT INTO Categories (CategoryName) VALUES ('Custom Creations');
INSERT INTO Categories (CategoryName) VALUES ('Sweet Dessert Pizzas');
INSERT INTO Categories (CategoryName) VALUES ('Low-Calorie Pizzas');
INSERT INTO Categories (CategoryName) VALUES ('Spicy Specials');
INSERT INTO Categories (CategoryName) VALUES ('International Flavors');
INSERT INTO Categories (CategoryName) VALUES ('Cheese Lovers Paradise');


INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Margherita Pizza', 'Classic tomato and mozzarella', 12.99, 50, 1);
INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Pepperoni Pizza', 'Classic pepperoni and mozzarella', 14.99, 40, 2);
INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Vegetarian Delight', 'Assorted veggies with tomato and mozzarella', 13.99, 30, 1);
INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Meat Lovers Supreme', 'Pepperoni, sausage, and bacon with mozzarella', 16.99, 25, 2);
INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Hawaiian Paradise', 'Ham, pineapple, and mozzarella for a tropical twist', 15.99, 35, 1);
INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('BBQ Chicken Feast', 'Grilled chicken, BBQ sauce, and mozzarella', 17.99, 20, 2);
INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Mushroom Madness', 'Fresh mushrooms with tomato and mozzarella', 14.99, 28, 1);
INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Supreme Combo', 'Pepperoni, sausage, mushrooms, onions, and mozzarella', 18.99, 22, 2);
INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Four Cheese Delight', 'Mozzarella, cheddar, feta, and parmesan blend', 16.99, 26, 1);
INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Spicy Chicken Ranch', 'Spicy chicken, ranch dressing, and mozzarella', 17.99, 18, 2);
INSERT INTO Products (Name, Description, Price, StockQuantity, CategoryID)
VALUES ('Veggie Supreme', 'Assorted veggies with tomato and mozzarella', 15.99, 32, 1);

INSERT INTO Product_Reviews (UserID, ProductID, Rating, Comments, Timestamp)
VALUES (1, 1, 4.5, 'Delicious pizza!', SYSTIMESTAMP);

INSERT INTO Shipping_Methods (ShippingMethodName, ShippingCost) VALUES ('Standard', 5.99);
INSERT INTO Shipping_Methods (ShippingMethodName, ShippingCost) VALUES ('Express', 9.99);

INSERT INTO Payment_Methods (PaymentMethodName) VALUES ('Credit Card');
INSERT INTO Payment_Methods (PaymentMethodName) VALUES ('PayPal');

INSERT INTO Orders (UserID, TotalAmount, PaymentMethodID, ShippingMethodID)
VALUES (1, 25.99, 1, 1);

INSERT INTO Order_Items (OrderID, ProductID, Quantity, Subtotal)
VALUES (1, 1, 2, 25.99);

INSERT INTO Promotions (PromotionName, DiscountAmount, StartDate, EndDate)
VALUES ('20% off', 20.00, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-31', 'YYYY-MM-DD'));

INSERT INTO Cart (UserID) VALUES (2);
INSERT INTO Cart_Items (CartID, ProductID, Quantity) VALUES (1, 2, 1);

INSERT INTO Applied_Promotions (OrderID, PromotionID) VALUES (1, 1);

INSERT INTO Notifications (UserID, Message, Timestamp)
VALUES (1, 'Your order has been shipped!', SYSTIMESTAMP);

INSERT INTO Rewards (UserID, Points) VALUES (2, 50);
INSERT INTO Rewards (UserID, Points) VALUES (1, 30);
