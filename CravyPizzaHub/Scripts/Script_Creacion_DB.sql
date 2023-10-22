-- Crear tabla Users
CREATE TABLE Users (
  UserID NUMBER PRIMARY KEY,
  Username NVARCHAR2(50) UNIQUE NOT NULL,
  Password NVARCHAR2(255) NOT NULL,
  Email NVARCHAR2(100) UNIQUE NOT NULL,
  FirstName NVARCHAR2(50),
  LastName NVARCHAR2(50),
  Address NVARCHAR2(255),
  Phone NVARCHAR2(15)
);

-- Crear tabla Roles
CREATE TABLE Roles (
  RoleID NUMBER PRIMARY KEY,
  RoleName NVARCHAR2(50) NOT NULL
);

-- Crear tabla User_Roles
CREATE TABLE User_Roles (
  User_RoleID NUMBER PRIMARY KEY,
  UserID NUMBER,
  RoleID NUMBER
);

-- Crear tabla Products
CREATE TABLE Products (
  ProductID NUMBER PRIMARY KEY,
  Name NVARCHAR2(100) NOT NULL,
  Description NVARCHAR2(255),
  Price NUMBER(10, 2) NOT NULL,
  StockQuantity NUMBER NOT NULL,
  CategoryID NUMBER
);

-- Crear tabla Categories
CREATE TABLE Categories (
  CategoryID NUMBER PRIMARY KEY,
  CategoryName NVARCHAR2(50) NOT NULL
);

-- Crear tabla Product_Reviews
CREATE TABLE Product_Reviews (
  ReviewID NUMBER PRIMARY KEY,
  UserID NUMBER,
  ProductID NUMBER,
  Rating NUMBER(2, 1) NOT NULL,
  Comment NVARCHAR2(255),
  Timestamp TIMESTAMP
);

-- Crear tabla Orders
CREATE TABLE Orders (
  OrderID NUMBER PRIMARY KEY,
  UserID NUMBER,
  OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  TotalAmount NUMBER(10, 2),
  PaymentMethodID NUMBER,
  ShippingMethodID NUMBER
);

-- Crear tabla Order_Items
CREATE TABLE Order_Items (
  OrderItemID NUMBER PRIMARY KEY,
  OrderID NUMBER,
  ProductID NUMBER,
  Quantity NUMBER NOT NULL,
  Subtotal NUMBER(10, 2)
);

-- Crear tabla Payment_Methods
CREATE TABLE Payment_Methods (
  PaymentMethodID NUMBER PRIMARY KEY,
  PaymentMethodName NVARCHAR2(50) NOT NULL
);

-- Crear tabla Shipping_Methods
CREATE TABLE Shipping_Methods (
  ShippingMethodID NUMBER PRIMARY KEY,
  ShippingMethodName NVARCHAR2(50) NOT NULL,
  ShippingCost NUMBER(10, 2)
);

-- Crear tabla Cart
CREATE TABLE Cart (
  CartID NUMBER PRIMARY KEY,
  UserID NUMBER
);

-- Crear tabla Cart_Items
CREATE TABLE Cart_Items (
  CartItemID NUMBER PRIMARY KEY,
  CartID NUMBER,
  ProductID NUMBER,
  Quantity NUMBER NOT NULL
);

-- Crear tabla Promotions
CREATE TABLE Promotions (
  PromotionID NUMBER PRIMARY KEY,
  PromotionName NVARCHAR2(100) NOT NULL,
  DiscountAmount NUMBER(10, 2) NOT NULL,
  StartDate DATE,
  EndDate DATE
);

-- Crear tabla Applied_Promotions
CREATE TABLE Applied_Promotions (
  AppliedPromotionID NUMBER PRIMARY KEY,
  OrderID NUMBER,
  PromotionID NUMBER
);

-- Crear tabla Notifications
CREATE TABLE Notifications (
  NotificationID NUMBER PRIMARY KEY,
  UserID NUMBER,
  Message NVARCHAR2(255),
  Timestamp TIMESTAMP
);

-- Crear tabla Rewards
CREATE TABLE Rewards (
  RewardID NUMBER PRIMARY KEY,
  UserID NUMBER,
  Points NUMBER NOT NULL
);

-- Agregar restricciones de clave foránea
ALTER TABLE User_Roles ADD CONSTRAINT fk_User_Roles_UserID FOREIGN KEY (UserID) REFERENCES Users(UserID);
ALTER TABLE User_Roles ADD CONSTRAINT fk_User_Roles_RoleID FOREIGN KEY (RoleID) REFERENCES Roles(RoleID);
ALTER TABLE Products ADD CONSTRAINT fk_Products_CategoryID FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);
ALTER TABLE Product_Reviews ADD CONSTRAINT fk_Product_Reviews_UserID FOREIGN KEY (UserID) REFERENCES Users(UserID);
ALTER TABLE Product_Reviews ADD CONSTRAINT fk_Product_Reviews_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID);
ALTER TABLE Orders ADD CONSTRAINT fk_Orders_UserID FOREIGN KEY (UserID) REFERENCES Users(UserID);
ALTER TABLE Orders ADD CONSTRAINT fk_Orders_PaymentMethodID FOREIGN KEY (PaymentMethodID) REFERENCES Payment_Methods(PaymentMethodID);
ALTER TABLE Orders ADD CONSTRAINT fk_Orders_ShippingMethodID FOREIGN KEY (ShippingMethodID) REFERENCES Shipping_Methods(ShippingMethodID);
ALTER TABLE Order_Items ADD CONSTRAINT fk_Order_Items_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
ALTER TABLE Order_Items ADD CONSTRAINT fk_Order_Items_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID);
ALTER TABLE Cart ADD CONSTRAINT fk_Cart_UserID FOREIGN KEY (UserID) REFERENCES Users(UserID);
ALTER TABLE Cart_Items ADD CONSTRAINT fk_Cart_Items_CartID FOREIGN KEY (CartID) REFERENCES Cart(CartID);
ALTER TABLE Cart_Items ADD CONSTRAINT fk_Cart_Items_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID);
ALTER TABLE Applied_Promotions ADD CONSTRAINT fk_Applied_Promotions_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
ALTER TABLE Applied_Promotions ADD CONSTRAINT fk_Applied_Promotions_PromotionID FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID);
ALTER TABLE Notifications ADD CONSTRAINT fk_Notifications_UserID FOREIGN KEY (UserID) REFERENCES Users(UserID);
ALTER TABLE Rewards ADD CONSTRAINT fk_Rewards_UserID FOREIGN KEY (UserID) REFERENCES Users(UserID);
