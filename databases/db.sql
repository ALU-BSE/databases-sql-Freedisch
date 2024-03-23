USE freenine;

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2),
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    BuyerID INT,
    ProductID INT,
    TransactionDate DATE,
    Quantity INT,
    FOREIGN KEY (BuyerID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Users (Name, Email, Password) VALUES
('Test User', 'user@example.com', 'password1'),
('User1', 'user1@example.com', 'password2');

INSERT INTO Products (Name, Description, Price, UserID) VALUES
('Laptop', 'High-performance laptop', 999.99, 1),
('Smartphone', 'Latest smartphone model', 699.99, 2);

INSERT INTO Transactions (BuyerID, ProductID, TransactionDate, Quantity) VALUES
(1, 2, '2024-03-23', 1),
(2, 1, '2024-03-24', 2);

SELECT * FROM Products WHERE UserID = 1;

SELECT SUM(p.Price * t.Quantity) AS TotalSpent
FROM Transactions t
JOIN Products p ON t.ProductID = p.ProductID
WHERE t.BuyerID = 2;

SELECT p.Name, COUNT(t.TransactionID) AS TotalTransactions
FROM Transactions t
JOIN Products p ON t.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY TotalTransactions DESC
LIMIT 5;
