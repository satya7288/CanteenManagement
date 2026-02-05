-- Step 1: Create Database
CREATE DATABASE canteen_db;
USE canteen_db;

-- Step 2: Create Users Table
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL,  -- Changed from ENUM
    Email VARCHAR(100) NOT NULL UNIQUE,
    Mobile VARCHAR(15),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Changed from DATETIME
);
create table ans(id int AUTO_INCREMENT PRIMARY KEY,ans varchar(555));

-- Step 3: Create Food Table
CREATE TABLE Food (
    FoodID INT AUTO_INCREMENT PRIMARY KEY,
    FoodName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    PicturePath VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Changed from DATETIME
);

-- Step 4: Create Staff Table
CREATE TABLE Staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(45) NOT NULL UNIQUE,
    password VARCHAR(45) NOT NULL
);

-- Step 5: Create Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NULL,
    FoodID INT NOT NULL,
    Quantity INT NOT NULL,
    TotalPrice DECIMAL(10,2) NOT NULL,
    staffId INT NULL,  -- Changed to INT to match staff.id
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Changed from DATETIME
    Status VARCHAR(20) DEFAULT 'Pending',  -- Changed from ENUM
    INDEX idx_staffId (staffId),  -- Ensured staffId is indexed before foreign key
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL,
    FOREIGN KEY (FoodID) REFERENCES Food(FoodID) ON DELETE CASCADE,
    FOREIGN KEY (staffId) REFERENCES Staff(id) ON DELETE SET NULL
);

-- Step 6: Create Feedback Table
CREATE TABLE Feedback (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NULL,
    staffId INT NULL,
    FeedbackText VARCHAR(500) NOT NULL,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Changed from DATETIME
    INDEX idx_staffId_feedback (staffId),  -- Ensured staffId is indexed before foreign key
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL,
    FOREIGN KEY (staffId) REFERENCES Staff(id) ON DELETE SET NULL
);

-- Step 7: Create Questions Table
CREATE TABLE Questions (
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    QuestionText VARCHAR(255) NOT NULL,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Changed from DATETIME
);

-- Step 8: Insert Default Data
INSERT INTO Staff (username, password) VALUES ('staff', 'staff');
INSERT INTO Users (Username, Password, Role, Email, Mobile) 
VALUES ('admin', 'admin123', 'Admin', 'admin@example.com', '9876543210');

INSERT INTO Food (FoodName, Price, PicturePath) 
VALUES ('Burger', 5.99, '/images/burger.jpg'),
       ('Pizza', 8.99, '/images/pizza.jpg');

INSERT INTO Orders (UserID, FoodID, Quantity, TotalPrice, staffId, Status) 
VALUES (1, 1, 2, 11.98, 1, 'Pending');

INSERT INTO Feedback (UserID, staffId, FeedbackText) 
VALUES (1, 1, 'Great service!');

INSERT INTO Questions (QuestionText) 
VALUES ('What are the canteen timings?');