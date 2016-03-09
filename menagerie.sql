CREATE TABLE Product
(
    ID INT(11) PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    SKU VARCHAR(32) NOT NULL,
    Price DECIMAL(13,2) NOT NULL,
    Description TEXT NOT NULL,
    DeliveryOption INT(11),
    Image VARCHAR(255) NOT NULL,
    CreatedOn DATETIME DEFAULT 'CURRENT_TIMESTAMP' NOT NULL
);
CREATE INDEX Product_DeliveryOption_ID_fk ON Product (DeliveryOption);
CREATE UNIQUE INDEX Product_SKU_pk ON Product (SKU);
CREATE TABLE Category
(
    ID INT(11) PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    CreatedOn DATETIME DEFAULT 'CURRENT_TIMESTAMP'
);
CREATE TABLE ProductCategory
(
    ProductID INT(11) NOT NULL,
    CategoryID INT(11) NOT NULL,
    CreatedOn DATETIME DEFAULT 'CURRENT_TIMESTAMP',
    CONSTRAINT ProductCategory_Category_ID_fk FOREIGN KEY (CategoryID) REFERENCES Category (ID),
    CONSTRAINT ProductCategory_Product_ID_fk FOREIGN KEY (ProductID) REFERENCES Product (ID)
);
CREATE UNIQUE INDEX ProductCategory_CategoryID_ProductID_uindex ON ProductCategory (CategoryID, ProductID);
CREATE INDEX ProductCategory_Product_ID_fk ON ProductCategory (ProductID);
CREATE TABLE GiftCard
(
    ID INT(11) PRIMARY KEY NOT NULL,
    Occasion VARCHAR(16) NOT NULL,
    Size VARCHAR(16) NOT NULL,
    Comment VARCHAR(255) NOT NULL,
    `To` VARCHAR(50) NOT NULL,
    `From` VARCHAR(50) NOT NULL,
    CartID INT(11) NOT NULL,
    CreatedOn DATETIME DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    CONSTRAINT GiftCard_Cart_ID_fk FOREIGN KEY (CartID) REFERENCES Cart (ID)
);
CREATE INDEX GiftCard_Cart_ID_fk ON GiftCard (CartID);
CREATE TABLE Cart
(
    ID INT(11) PRIMARY KEY NOT NULL,
    CFIDsession INT(13) NOT NULL,
    Closed TINYINT(1) DEFAULT '0' NOT NULL,
    CreatedOn DATETIME DEFAULT 'CURRENT_TIMESTAMP' NOT NULL
);
CREATE TABLE DeliveryOption
(
    ID INT(11) PRIMARY KEY NOT NULL,
    `Option` VARCHAR(32) NOT NULL,
    CreatedOn DATETIME DEFAULT 'CURRENT_TIMESTAMP'
);
CREATE TABLE CartItem
(
    ID INT(11) PRIMARY KEY NOT NULL,
    ProductID INT(11) NOT NULL,
    CartID INT(11) NOT NULL,
    Quantity INT(11) NOT NULL,
    CreatedOn DATETIME DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    CONSTRAINT Item_Cart_ID_fk FOREIGN KEY (CartID) REFERENCES Cart (ID)
);
CREATE INDEX Item_Cart_ID_fk ON CartItem (CartID);
CREATE PROCEDURE initCart(CFID INT, cartID INT);






DROP PROCEDURE IF EXISTS menagerie.initCart;
CREATE DEFINER=`Derek`@`localhost` PROCEDURE `initCart`(IN CFID int(13), OUT cartID int(13))
BEGIN

    SELECT ID from Cart WHERE CFIDsession = CFID into cartID;

    IF (FOUND_ROWS() = 0) THEN
        -- insert a new cart record and return its ID
      INSERT INTO Cart (CFIDSession) VALUES (CFID);
      SELECT MAX(ID) FROM Cart INTO cartID;
    END IF;

  END;



#index.cfm
SELECT
    Product.ID,
    Product.Name,
    Product.SKU,
    Product.Price,
    Product.Description,
    DeliveryOption.Option AS DeliveryOption,
    Product.Image
FROM Product
    INNER JOIN ProductCategory ON Product.ID = ProductCategory.ProductID
    INNER JOIN Category ON ProductCategory.CategoryID = Category.ID
    INNER JOIN DeliveryOption ON Product.DeliveryOption = DeliveryOption.ID
WHERE Category.Name = 'Specials' Limit 5;

#same day delivery

SELECT
    Product.ID,
    Product.Name,
    Product.SKU,
    Product.Price,
    Product.Description,
    DeliveryOption.Option AS DeliveryOption,
    Product.Image
FROM Product
    INNER JOIN DeliveryOption ON Product.DeliveryOption = DeliveryOption.ID
WHERE DeliveryOption.`Option` = 'Same Day Delivery';


#get well soon
SELECT
    Product.ID,
    Product.Name,
    Product.SKU,
    Product.Price,
    Product.Description,
    DeliveryOption.Option AS DeliveryOption,
    Product.Image
FROM Product
    INNER JOIN ProductCategory ON Product.ID = ProductCategory.ProductID
    INNER JOIN Category ON ProductCategory.CategoryID = Category.ID
    INNER JOIN DeliveryOption ON Product.DeliveryOption = DeliveryOption.ID
WHERE Category.Name = 'Get Well Soon' ;


#baskets
SELECT
    Product.ID,
    Product.Name,
    Product.SKU,
    Product.Price,
    Product.Description,
    DeliveryOption.Option AS DeliveryOption,
    Product.Image
FROM Product
    INNER JOIN ProductCategory ON Product.ID = ProductCategory.ProductID
    INNER JOIN Category ON ProductCategory.CategoryID = Category.ID
    INNER JOIN DeliveryOption ON Product.DeliveryOption = DeliveryOption.ID
WHERE Category.Name = 'Baskets';

#product detail
SELECT
    Product.ID,
    Product.Name,
    Product.SKU,
    Product.Price,
    Product.Description,
    Product.Image,
    DeliveryOption.Option DeliveryOption FROM Product
    INNER JOIN DeliveryOption ON Product.DeliveryOption = DeliveryOption.ID
WHERE Product.ID = ?;

#cart page

SELECT
    Product.ID,
    Name,
    SKU,
    Price * Quantity as Price,
    Quantity,
    CartItem.ID as ItemID
FROM Product INNER JOIN CartItem ON Product.ID = CartItem.ProductID
WHERE CartID = ?;

